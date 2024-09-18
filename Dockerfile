FROM ubuntu:20.04

COPY entrypoint.sh .

RUN apt-get update && apt-get install -y \
        wget && \
    wget https://github.com/eosio/eos/releases/download/v2.1.0/eosio_2.1.0-1-ubuntu-20.04_amd64.deb && \
    apt-get install -y ./eosio_2.1.0-1-ubuntu-20.04_amd64.deb && \
    wget https://github.com/eosio/eosio.cdt/releases/download/v1.8.0/eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb && \
    apt-get install -y ./eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb && \
    cleos wallet create -f /tmp/cleos_default_pass && \
    cleos wallet create_key | egrep 'EOS[a-zA-Z0-9]{50}' --only-match > /tmp/cleos_default_pub_key && \
    cleos wallet import --private-key '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3' && \
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
