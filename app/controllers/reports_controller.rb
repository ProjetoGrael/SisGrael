class ReportsController < ApplicationController
  before_action only: [:financeiro, :generate_financial_report] do 
    authorize! :read, :financial
  end
  
    def financeiro
    end

    def generate_financial_report
      info = financial_params
      @kind = info[:report_kind]
 
      @records = if @kind == "transaction_category"
        Financial::TransactionCategory.get_report_data(info)
      elsif @kind == "account"
        Financial::Account.get_report_data(info)
      elsif @kind == "organization" || @kind == "enterprise"
        Financial::Institution.get_report_data(info)
      end
      @current_value = BigDecimal('0')
      if @records
        @records.each { |s| @current_value += s.value }
      else
        @records = []
      end
      respond_to do |format|
        format.xlsx do

        end
        format.pdf do
          render pdf: 'generate_financial_report.pdf.erb',
          orientation: 'Landscape',
          title: 'Relatório Financeiro '+Date.today.strftime("%d/%m/%y"),
          header: {right: '[page] de [topage]'}
        end
      end
    end

    private
      def financial_params
        params.permit(:id, :beggining, :final, :report_kind)
      end
end
