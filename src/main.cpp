#include "/usr/opt/eosio.cdt/1.8.1/include/eosiolib/contracts/eosio/contract.hpp"
#include "/usr/opt/eosio.cdt/1.8.1/include/eosiolib/contracts/eosio/eosio.hpp"
#include "/usr/opt/eosio.cdt/1.8.1/include/eosiolib/contracts/eosio/action.hpp"
#include "/usr/opt/eosio.cdt/1.8.1/include/eosiolib/contracts/eosio/table.hpp"

using namespace eosio;

CONTRACT simplecontract : public contract::contract {
public:
    using contract::contract;

    ACTION set(name user, uint64_t value) {
        require_auth(user); // Проверка авторизации

        // Сохраняем значение в таблице
        values_table values(get_self(), get_self().value);
        values.emplace(user, [&](auto& row) {
            row.key = user.value;
            row.value = value;
        });
    }

    ACTION get(name user) {
        values_table values(get_self(), get_self().value);
        auto iterator = values.find(user.value);
        check(iterator != values.end(), "Value not found");

        // Печатаем значение
        print("Value for user ", user, ": ", iterator->value);
    }

private:
    TABLE value_row {
        uint64_t key;
        uint64_t value;

        uint64_t primary_key() const { return key; }
    };

    typedef multi_index < "values"_n, value_row> values_table;
};

EOSIO_DISPATCH(simplecontract, (set)(get))



int main()
{
}
