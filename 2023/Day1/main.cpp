#include <fstream>
#include <iostream>
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
    nums["zero"] = 0;

    if (!infile.is_open()) {
        std::cerr << "Error opening file." << std::endl;
        return 1;
    }

    std::string line;

    int total=0;


    while (std::getline(infile, line)) {
        int first = -1;
        int last = -1;
        int next = 0;
        for (char ch : line){
            if(isdigit(ch) ||  ){
                if(first == -1){
                    first = ch - '0';
                }
            }
            if(isdigit(ch)){
                next = ch - '0';   
            }
        }
        last = next;
        int combine = (first*10) + last;
        total += combine;
    }
    

    return total;
}
