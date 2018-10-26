
# 在线编辑器
# https://editor.swagger.io/


# 本地编辑器(git)
# https://github.com/swagger-api/swagger-editor
# git clone https://github.com/swagger-api/swagger-editor
# cp -r index.html dist TARGET/

# 本地编辑器(npm)
# npm i swagger-editor-dist
# npm i -g local-web-server
# ws -d node_modules/swagger-editor-dist


# swagger 输出
# https://github.com/Swagger2Markup/swagger2markup
# http://swagger2markup.github.io/swagger2markup/1.3.3/#_command_line_interface
# https://jcenter.bintray.com/io/github/swagger2markup/swagger2markup-cli/1.3.3/
# wget https://jcenter.bintray.com/io/github/swagger2markup/swagger2markup-cli/1.3.3/:swagger2markup-cli-1.3.3.jar
sudo cat <<EOF > /usr/local/bin/swagger-markup
#!/bin/zsh
java -jar /work/java/swagger2markup-cli-1.3.3.jar $@
EOF
sudo chmod +x /usr/local/bin/swagger-markup

# mkdir swagger-pets && cd swagger-pets
# get sample.yml from https://editor.swagger.io

# swagger ==> asciidoc
# swagger-markup convert -i swagger.yaml -f swagger

# swagger ==> markdown
# echo "swagger2markup.markupLanguage=MARKDOWN" > config.properties
# swagger-markup convert -i swagger.yaml -f swagger -c config.properties


# API SDK 代码生成
# https://gumroad.com/l/swagger_codegen_beginner
# https://gumroad.com/l/swagger_codegen_beginner_zh

# https://github.com/swagger-api/swagger-codegen
# wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.3.1/swagger-codegen-cli-2.3.1.jar -O swagger-codegen-cli.jar


# https://app.swaggerhub.com/apis/nochtavio/ats-swagger/1.0.0
# https://app.swaggerhub.com/apis-docs/nochtavio/ats-swagger/1.0.0
