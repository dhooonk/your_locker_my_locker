class IndexController < ApplicationController
  def index
    #응용화학과
    if user_signed_in?
      if current_user.major == "응용화학과"
        @time1 = TimeLimit.find(1)
          if current_user.identity == "student"
            @startTime1 = @time1.studentTimeStart
            @finishTime1 = @time1.studentTimeEnd
          end
      end
    end
  end
end
