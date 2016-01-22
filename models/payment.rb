class Payment < RemoteRecord::Base
  source :folio
  attr_writer :show_in_list

  convert :accounting_date, :to_date
  convert :payment_date,    :to_date
  convert :amount,          :to_f

  delegate \
    :cancelled?,
    :errored?,
    :misapplied?,
    :pending?,
    :returned?,
    :scheduled?,
    :sent?,
    :settled?,
    to: :payment_status
  convert :payment_status, :inquiry

  def incoming?
    incoming
  end

  def display_for_client?
    display_for_client
  end

  def ach?
    payment_method == 'ach'
  end

  def unscheduled?
    !scheduled?
  end

  def description
    if ach?
      "#{bank_account.bank_name.titleize} - #{bank_account.account_number} (ACH)"
    else
      display_payment_method
    end
  end

  def show_in_list?
    @show_in_list || false
  end

  def bank_account
    @bank_account ||= BankAccount.find(payment_account_id)
  end
end
