#ifndef CORE_HEADERS_SYSTEM_BASE_HPP
#define CORE_HEADERS_SYSTEM_BASE_HPP

#include <string>


namespace SystemBase
{
    class Base
    {
        public:
            std::string sayHello() const;
            std::string connectionStatus() const;
    };
}

#endif