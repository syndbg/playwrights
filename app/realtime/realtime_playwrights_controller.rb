class RealtimePlaywrightsController < FayeRails::Controller
  channel '/playwrights' do
    subscribe do
      Rails.logger.debug "Client #{inspect} subscribed to #{channel}."

      Playwright.find_by_id(message['id'])
        .update!(text: message['text']) if message['type'] == 'text-save' &&
                                           message['id'].present?
    end

    monitor :subscribe do
      Rails.logger.debug "Client #{client_id} subscribed to #{channel}."
    end

    monitor :unsubscribe do
      Rails.logger.debug "Client #{client_id} unsubscribed from #{channel}."
    end

    monitor :publish do
      Rails.logger.debug "Client #{client_id} published #{data.inspect} to #{channel}."
    end
  end
end
