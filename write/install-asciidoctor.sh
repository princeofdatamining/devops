
# https://asciidoctor.org/docs/install-toolchain/
gem install asciidoctor
# asciidoctor --version


# asciidoc ==> html
# asciidoctor FILE


# asciidoc ==> pdf
# https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic
# gem install asciidoctor-pdf-cjk-kai_gen_gothic
# asciidoctor-pdf-cjk-kai_gen_gothic-install
# /PTH/rvm/gems/ruby-2.5.1/gems/asciidoctor-pdf-cjk-kai_gen_gothic-0.1.1/data/fonts/*.ttf
# /Library/Ruby/Gems/2.3.0/gems/asciidoctor-pdf-cjk-kai_gen_gothic-0.1.1/data/fonts/
# asciidoctor-pdf -r asciidoctor-pdf-cjk-kai_gen_gothic -a pdf-style=KaiGenGothicCN doc.asc

# https://github.com/asciidoctor/asciidoctor-pdf
# gem install asciidoctor-pdf --pre
# asciidoctor -r asciidoctor-pdf -b pdf basic-example.adoc

# https://github.com/chloerei/asciidoctor-pdf-cjk
# gem install asciidoctor-pdf-cjk
# asciidoctor-pdf -r asciidoctor-pdf-cjk doc.asc

# asciidoc ==> DocBook ==> pdf
# https://github.com/asciidoctor/asciidoctor-fopub
