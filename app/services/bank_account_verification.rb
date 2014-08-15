class BankAccountVerification < Struct.new(:bank_account)
  def valid?(params)
    begin
      verification = Balanced::BankAccountVerification.fetch("/verifications/#{bank_account.gateway_reference_id}")
      verification.confirm(params[:amount1], params[:amount2])

      # TODO: add case for win the verification exceeded the tries
      if verification.attributes['verification_status'] == 'succeeded'
        return true
      end
    rescue Balanced::Error => e
      # TODO log exception
      return false
    end
    return false
  end
end