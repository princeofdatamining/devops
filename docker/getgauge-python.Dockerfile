FROM python

RUN wget -qO- https://github.com/getgauge/infrastructure/raw/master/nightly_scripts/install_latest_gauge_nightly.sh | bash
RUN gauge install python
RUN gauge install screenshot
RUN gauge install html-report
RUN gauge install xml-report
RUN gauge install json-report

RUN pip3 install --upgrade pip
