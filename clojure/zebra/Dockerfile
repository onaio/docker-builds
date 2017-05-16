FROM onaio/clojure

ENV ONA_LOAD_HELPSCOUT false

COPY zebra-entrypoint.sh /
RUN chmod 755 /zebra-entrypoint.sh
ENTRYPOINT ["/zebra-entrypoint.sh"]
EXPOSE 3000

