#include <regex>
#include <fstream>
#include <iostream>
#include <string>
#include <istream>
#include <vector>


using namespace std;

int game();
string test = "test.txt";
string real = "real.txt";
std::ifstream infile(real);
int main(){
    cout << game() << endl;
}
int game(){
    if (!infile.is_open()) {
        std::cerr << "Error opening file." << std::endl;
        return 1;
    }

    string line;
    int total=0;

    while (getline(infile, line)) {
        std::istringstream iss(line);
        std::vector<std::string> substrings;
        std::string substring;
        while (getline(iss, substring, ';')) {
            substrings.push_back(substring);
        }
        bool good = true;
        int redNum = -1;
        int greenNum = -1;
        int blueNum = -1;
        for(const auto& show : substrings){ 
            regex redPattern("\\b(\\d+)\\s+red\\b"); 
            smatch redMatch;
            regex greenPattern("\\b(\\d+)\\s+green\\b"); 
            smatch greenMatch;
            regex bluePattern("\\b(\\d+)\\s+blue\\b"); 
            smatch blueMatch;
            if (regex_search(show, redMatch, redPattern)) {
                if((stoi(redMatch[1])) > redNum ){
                    redNum = stoi(redMatch[1]);
                }
            }
            if (regex_search(show, greenMatch, greenPattern)) {
                if((stoi(greenMatch[1])) > greenNum ){
                    greenNum = stoi(greenMatch[1]);
                }
            }
            if (regex_search(show, blueMatch, bluePattern)) {
                if((stoi(blueMatch[1])) > blueNum ){
                    blueNum = stoi(blueMatch[1]);
                }
            }
        }
        total += (redNum * blueNum * greenNum);
    }
    return total;
}

