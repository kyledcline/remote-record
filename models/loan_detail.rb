class LoanDetail < RemoteRecord::Base
  source :folio

  convert :accounts,                          :to_struct
  convert :balances,                          :to_struct
  convert :upcoming_payment,                  :to_struct
  convert :past_due,                          :to_f
  convert :current_installment_scheduled_sum, :to_f
  convert :pay_off_date,                      :to_date
end
