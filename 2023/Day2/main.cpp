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
    int gameNum = 1;
    while (getline(infile, line)) {
        cout << line << endl; 
        std::istringstream iss(line);

        std::vector<std::string> substrings;

        std::string substring;
        while (getline(iss, substring, ';')) {
            substrings.push_back(substring);
        }
        bool good = true;
        for(const auto& show : substrings){ 
            
            int redNum = -1;
            int greenNum = -1;
            int blueNum = -1;
            regex redPattern("\\b(\\d+)\\s+red\\b"); 
            smatch redMatch;
            regex greenPattern("\\b(\\d+)\\s+green\\b"); 
            smatch greenMatch;
            regex bluePattern("\\b(\\d+)\\s+blue\\b"); 
            smatch blueMatch;
            if (regex_search(show, redMatch, redPattern)) {
                redNum = stoi(redMatch[1]);
            }
            if (regex_search(show, greenMatch, greenPattern)) {
                greenNum = stoi(greenMatch[1]);
            }
            if (regex_search(show, blueMatch, bluePattern)) {
                blueNum = stoi(blueMatch[1]);
            }
            if(redNum > 12 || greenNum > 13 || blueNum > 14){
                good = false; 
            }
        }
        if(good){
            total += gameNum;
        }

        cout << "Game: " << gameNum << " Total: " << total << endl;
        gameNum++;
    }
    return total;
}

