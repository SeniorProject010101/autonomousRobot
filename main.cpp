#include "core/headers/connection.hpp"
#include "core/headers/systemBase.hpp"
#include <iostream>

int main()
{
	SystemBase::Base base;
    Connection connect;
	std::cout << base.sayHello() << '\n';
    std::string showConnection = connect.connection();
    
    // connection is up
    std::cout << showConnection << '\n';
	return 0;
}