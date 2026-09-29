#include "core/headers/connection.hpp"
#include "core/headers/logic.hpp"
#include "core/headers/systemBase.hpp"
#include <iostream>

int main()
{
    // make objects for each class
    SystemBase::Base base;
    Connection connect;
    Logic logic;

    // base class
	std::cout << base.sayHello() << '\n';
    
    // connection is up
    std::string showConnection = connect.connection();
    std::cout << showConnection << '\n';

    // logic
    std::string showLogic = logic.sayLogic();
    std::cout << showLogic << '\n';
	return 0;
}