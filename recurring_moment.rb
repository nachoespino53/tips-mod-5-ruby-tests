require 'active_support'
require 'active_support/core_ext'
require 'pry'

class RecurringMoment
  def initialize(start:, interval:, period:)
    # Start is DateTime
    @start = start
    # Interval is int
    @interval = interval
    # Period is 'monthly', 'daily', or 'weekly'
    @period = period
  end

  def match(date)
    # Current is DateTime
    current = @start
    
    while current <= date

      if current == date
        return true
      end

      if @period == 'monthly'
        # Issues here lie with the date differences between the months
        # Issue 1, Jan 31.advance(months: 1)
        # Day 31st, will always be end of month
        # Issue 2, Jan 30.advance(months: 1)
        # Day 30th is not always end of month, but advancing could be true depending on our assumptions
        # Issue 3, Jan 29.advance(months: 1)
        # This date is in question only for January
        # This issue can be repeated throughout the rest of the months.
        
        
        # To solve end of month, we can always assume end of month
        
        # Check to see if it's the end of the month
        # Playing with the code, Jan 31 -> Feb 28 -> Mar 28
        # PsuedoCode
        # Best way to check if a date is end of month, check the next day
        
        current = current.advance(months: @interval)
        if @start.advance(days: 1).day == 1 && current.day != @start.day
          current = current.end_of_month.beginning_of_day
        end
      elsif @period == 'weekly'
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end

    return false
  end
end
