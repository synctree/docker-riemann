FROM java:7-jre

ENV RIEMANN_VERSION 0.2.8

RUN curl -SL https://aphyr.com/riemann/riemann_${RIEMANN_VERSION}_all.deb -o riemann.deb \
    && dpkg -i riemann.deb \
    && rm riemann.deb

RUN sed -i -e '/logging\/init/s#^.*$#(logging/init { :console true })#; \
               s/host "127.0.0.1"/host "0.0.0.0"/' /etc/riemann/riemann.config

CMD ["riemann", "-a"]
EXPOSE 5555 5555/udp
EXPOSE 5556
