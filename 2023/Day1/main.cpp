#include <cstddef>
#include <fstream>
#include <limits>
#include <iostream>
#include <ostream>
#include <string>
#include <cctype>
#include <map>


using namespace std;

string test = "test.txt";
string real = "real.txt";
int find_fnl();
std::ifstream infile(real);



int main() {
    cout<<find_fnl()<<endl;

}

int find_fnl(){
    std::map<std::string, int> nums;
    nums["one"] = 1;
    nums["two"] = 2;
    nums["three"] = 3;
    nums["four"] = 4;
    nums["five"] = 5;
    nums["six"] = 6;
    nums["seven"] = 7;
    nums["eight"] = 8;
    nums["nine"] = 9;

    if (!infile.is_open()) {
        std::cerr << "Error opening file." << std::endl;
        return 1;
    }

    std::string line;

    int total=0;


    while (std::getline(infile, line)) {
        cout << line << endl;
        int first = -1;
        int last = -1;
        int next = 0;
        int firstPos=numeric_limits<int>::max();
        int lastPos=-1;
        for (const auto& pair : nums) {
            int position = line.find(pair.first);
            if (position != std::string::npos) {
                if(position < firstPos) {
                    firstPos = position;
                    first = pair.second;
                    cout << "First: " << first << endl;
                }
                if(position > lastPos){
                    lastPos = position;
                    last = pair.second;
                    cout << "Last: " << last << endl;
                }
            }
        }
        int count = 0;
        for( char ch : line ) {
            if(count < firstPos && isdigit(ch)){
                first = ch - '0';
                firstPos = count;
                cout << "New First: " << first << endl;
            }
            if(count > lastPos && isdigit(ch)){
                last = ch - '0';  
                lastPos = count;
                cout << "New Last: " << last<< endl;
            }
            count++;
        }
        cout << "First: " << first << " Last: " << last << endl; 
        int combine = (first*10) + last;
        cout << "Combine: " << combine << endl;
        total += combine;
        cout << "Total: " << total << endl;
    }
    return total;
}
