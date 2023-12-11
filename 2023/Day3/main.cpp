#include <cctype>
#include <iostream>
#include <fstream>
#include <string>
#include <istream>
#include <vector>

using namespace std;

int partNums();
int check_digit(int, int, int, const vector<vector<char>>& chars);
bool check_spec(int, int, int,  const vector<vector<char>>& chars);
int combine(int, int, int, const vector<vector<char>>& chars);

int main(){
    cout << partNums() << endl;
}

int partNums(){
    string test = "test.txt";
    string real = "real.txt";
    int m = 140;
    std::ifstream infile(real);
    
    int total = 0;
    string line;

    vector<vector<char>> chars(m, vector<char>(m));

    int rows = 0;
    int cols = 0;
    while (getline(infile, line)) {
        cols = 0;
        for(char ch : line){
            chars[rows][cols] = ch;
            cout << ch;
            cols++;
        }    
        cout << endl;
        rows++;
    }

    for(int i = 0; i < rows; i++){
        for(int j = 0; j < cols; j++){
            char ch = chars[i][j];
            //cout << "Char: " << ch << endl;
            int digits = 0;
            if(isdigit(ch)){
                digits = check_digit(1, i, j + 1, chars);
                //cout << "Num Digits: " << digits << endl;
                if(check_spec(digits, i, j, chars)){
                    if(digits > 1){
                        total += combine(digits, i, j, chars);
                        cout << combine(digits, i, j, chars)<< endl;
                    } else {
                        total += (chars[i][j] - '0');
                        cout << chars[i][j]<< endl;
                    }
                }
                j += digits;
            }
        }
    }
    return total;
}

int check_digit(int digits, int row, int col, const vector<vector<char>>& chars){
    if(!(isdigit(chars[row][col])) || (col + 1) >= chars[row].size()){
        return digits;
    }
    return check_digit(digits + 1, row, (col + 1), chars);   
}

bool check_spec(int digits, int row, int col, const vector<vector<char>>& chars){
    int top = max(row - 1, 0);
    int bottom = min(row + 1, static_cast<int>(chars.size()) - 1);
    int front = max(col - 1, 0);
    int back = min(col + digits, static_cast<int>(chars[row].size()) - 1);
//    cout << "Check_spec:" << endl;
//    cout << "   Top: " << top << endl;
//    cout << "   Bottom: " << bottom <<endl;
//    cout << "   Front: " << front << endl;
//    cout << "   Back: " << back << endl;

    for(int i = top; i <= bottom; i++){
        for(int j = front; j <= back; j++){
            char ch = chars[i][j];
//            cout << "   row: " << i << endl;
//            cout << "   col: " << j << endl;
            if(!(isalnum(ch) || ch == '.')){
                cout << "char: " << ch << ", ";
                return true;
            }
        }
    }
    return false;
}

int combine(int digits, int row, int col, const vector<vector<char>>& chars){
    int combined = 0;

    for(int i = col; i < col + digits; ++i){
        combined = combined * 10 + (chars[row][i] - '0');
    }
    return combined;
}

