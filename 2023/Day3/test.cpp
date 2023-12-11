#include <iostream>
#include <fstream>
#include <cctype>
#include <vector>

using namespace std;

int sumOfPartNumbers(const vector<string>& engine);

int main() {
    ifstream infile("test.txt");  // Replace with the actual file name
    if (!infile.is_open()) {
        cerr << "Unable to open file." << endl;
        return 1;
    }

    vector<string> engine;
    string line;
    while (getline(infile, line)) {
        engine.push_back(line);
    }

    int result = sumOfPartNumbers(engine);
    cout << "Sum of part numbers: " << result << endl;

    return 0;
}

bool isValidSymbol(char symbol) {
    return isalnum(symbol) || symbol == '#';
}

int sumOfPartNumbers(const vector<string>& engine) {
    int sum = 0;

    for (int i = 0; i < engine.size(); ++i) {
        for (int j = 0; j < engine[i].size(); ++j) {
            char currentChar = engine[i][j];

            if (isdigit(currentChar)) {
                // Check adjacent positions for symbols
                for (int x = i - 1; x <= i + 1; ++x) {
                    for (int y = j - 1; y <= j + 1; ++y) {
                        if (x >= 0 && x < engine.size() && y >= 0 && y < engine[i].size() && (x != i || y != j)) {
                            char adjacentChar = engine[x][y];
                            if (isValidSymbol(adjacentChar)) {
                                sum += currentChar - '0';  // Convert char to int
                                break;  // Break out of the inner loop once an adjacent symbol is found
                            }
                        }
                    }
                    if (sum > 0) {
                        break;  // Break out of the outer loop once an adjacent symbol is found
                    }
                }
            }
        }
    }

    return sum;
}
