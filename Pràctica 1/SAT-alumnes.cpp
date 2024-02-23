#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <vector>
#include <unordered_map>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;
vector<double> activity;
double decayFactor = 0.95; // Factor de decaimiento para actualizar los puntajes de actividad
double incrementFactor = 1.0; // Factor de incremento para actualizar los puntajes de actividad al tomar una decisión

void readClauses() {
    char c = cin.get();
    while (c == 'c') {
        while (c != '\n') c = cin.get();
        c = cin.get();
    }
// Read "cnf numVars numClauses"
    string aux;
    cin >> aux >> numVars >> numClauses;
    clauses.resize(numClauses);
// Read clauses
    for (uint i = 0; i < numClauses; ++i) {
        int lit;
        while (cin >> lit and lit != 0) clauses[i].push_back(lit);
    }
}

int currentValueInModel(const int& lit) {
    if (lit >= 0)
        return model[lit];
    else
        return (model[-lit] == UNDEF) ? UNDEF : 1 - model[-lit];
}

void setLiteralToTrue(int lit) {
    modelStack.push_back(lit);
    if (lit > 0) model[lit] = TRUE;
    else model[-lit] = FALSE;
}

bool propagateGivesConflict() {
    while (indexOfNextLitToPropagate < modelStack.size()) {
        ++indexOfNextLitToPropagate;
        std::vector<int> unitClauses;
        
        for (const auto& clause : clauses) {
            bool someLitTrue = false;
            int numUndefs = 0;
            int lastLitUndef = 0;
            
            for (int lit : clause) {
                int val = currentValueInModel(lit);
                if (val == TRUE) {
                    someLitTrue = true;
                    break;  // Si un literal es verdadero, no es necesario seguir evaluando la cláusula.
                }
                else if (val == UNDEF) {
                    ++numUndefs;
                    lastLitUndef = lit;
                }
            }
            
            if (!someLitTrue) {
                if (numUndefs == 0) return true; // Conflicto: todos los literales son falsos.
                else if (numUndefs == 1) unitClauses.push_back(lastLitUndef); // Cláusula unitaria.
            }
        }
        
        // Propagar cláusulas unitarias
        for (int lit : unitClauses) {
            setLiteralToTrue(lit);
        }
    }
    
    return false;
}


void backtrack() {
    uint i = modelStack.size() - 1;
    int lit = 0;
    while (modelStack[i] != 0) {
        lit = modelStack[i];
        model[abs(lit)] = UNDEF;
        modelStack.pop_back();
        --i;
    }
    modelStack.pop_back();
    --decisionLevel;
    indexOfNextLitToPropagate = modelStack.size();
    setLiteralToTrue(-lit);
}

int getNextDecisionLiteral() {
    unordered_map<int, double> scores; // Mapa para rastrear los puntajes de actividad de las variables
    for (const auto& clause : clauses) {
        for (int lit : clause) {
            int var = abs(lit);
            if (model[var] == UNDEF) scores[var] += incrementFactor;
        }
    }

    // Aplicar decaimiento a los puntajes de actividad
    for (auto& [var, score] : scores) {
        score *= decayFactor;
    }

    // Selección de la variable con el puntaje más alto
    int maxScoreVar = 0;
    double maxScore = 0;
    for (const auto& [var, score] : scores) {
        if (score > maxScore) {
            maxScore = score;
            maxScoreVar = var;
        }
    }
    return maxScoreVar;
}



void checkmodel() {
    for (const auto& clause : clauses) {
        bool someTrue = false;
        for (int lit : clause) {
            someTrue = (currentValueInModel(lit) == TRUE);
            if (someTrue) break;
        }
        if (!someTrue) {
            cout << "Error in model, clause is not satisfied:";
            for (int lit : clause) std::cout << lit << " ";
            cout << endl;
            exit(1);
        }
    }
}

int main() {
    readClauses();
    model.resize(numVars + 1, UNDEF);
    indexOfNextLitToPropagate = 0;
    decisionLevel = 0;

    for (const auto& clause : clauses) {
        if (clause.size() == 1) {
            int lit = clause[0];
            int val = currentValueInModel(lit);
            if (val == FALSE) {
                cout << "UNSATISFIABLE" << endl;
                return 10;
            } else if (val == UNDEF) {
                setLiteralToTrue(lit);
            }
        }
    }

    while (true) {
        while (propagateGivesConflict()) {
            if (decisionLevel == 0) {
                cout << "UNSATISFIABLE" << endl;
                return 10;
            }
            backtrack();
        }
        int decisionLit = getNextDecisionLiteral();
        if (decisionLit == 0) { 
            checkmodel(); 
            cout << "SATISFIABLE" << endl; 
            return 20; 
        }
        // start new decision level:
        modelStack.push_back(0);  // push mark indicating new DL
        ++indexOfNextLitToPropagate;
        ++decisionLevel;
        setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
    }
}
