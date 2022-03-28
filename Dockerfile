FROM confluentinc/cp-kafka-connect-base:7.0.1

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-azure-blob-storage:1.1.1
COPY --chown=appuser:appuser *.sh ./

CMD ["/home/appuser/entrypoint.sh"]