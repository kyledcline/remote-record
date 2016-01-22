class BankAccount < RemoteRecord::Base
  source :rolodex

  delegate :good?, :bad?, :closed?, to: :payment_account_status
  convert :payment_account_status, :inquiry

  def account_number
    mask(instance.account_number, 4)
  end

  private

  def mask(string, from_last, mask_char = 'X')
    string.to_s.length <= from_last ? string : (mask_char * (string.length - from_last)) + string.to_s.slice(-from_last..-1)
  end
end
