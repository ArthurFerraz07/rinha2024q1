# Defina a imagem base como a versão mais recente do Ruby
FROM ruby:3.1.3

# Crie o diretório de trabalho para o aplicativo
RUN mkdir -p /rinha_api
WORKDIR /rinha_api

# Copie os arquivos do aplicativo para o contêiner
COPY ./rinha_api /rinha_api

# Instale as dependências do sistema necessárias para o aplicativo Rails
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Instale as dependências do Ruby necessárias para o aplicativo Rails
RUN gem install bundler
RUN bundle install --jobs 4

# Exponha a porta em que o aplicativo estará em execução
EXPOSE 3000
