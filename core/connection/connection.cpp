#include "../headers/connection.hpp"
#include "../headers/systemBase.hpp"
#include <iostream>

std::string Connection::connection()
{
    SystemBase::Base base;

    // message that says connection is up comes from connection status
    std::string connectionBase = base.connectionStatus();

    // message that says hello world
    std::cout << "hello world" << std::endl;
    return connectionBase;
}