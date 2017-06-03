require 'mail'

module Pigeon
  # A GMail account to deliver logs to.
  class GMailAccount
    # @return [String] account username
    attr_reader :user_name

    # @return [String] email address
    attr_reader :email_address

    # @return [String] account password
    attr_reader :password

    def initialize(user_name, password)
      @user_name = user_name
      @email_address = user_name + "@gmail.com"
      @password = password
    end

    # Sends an email
    # @param address [String] destination email address
    # @param subj [String] subject of the email
    # @param bod [String] body (content) of the email
    def send!(address, subj, bod)
      mail = Mail.new do
        from @email_address
        to address
        subject subj
        body bod
      end

      mail.delivery_method(
        :smtp,
        address: 'smtp.gmail.com',
        domain: 'gmail.com',
        port: 587,
        user_name: user_name,
        password: password,
        authentication: 'plain',
        enable_starttls_auto: true
      )

      mail.deliver!
    end
  end
end
