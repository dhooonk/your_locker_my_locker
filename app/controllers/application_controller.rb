class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  added_attrs = [:studentNumber, :phoneNumber, :feeOfSchool, :notation, :email, :major, :name, :identity, :password, :password_confirmation, :remember_me]
  update_attrs = [:password, :password_confirmation, :current_password]

  devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  devise_parameter_sanitizer.permit :account_update, keys: update_attrs
end

  def adminNot?
    if (current_user.identity != "admin")
      redirect_to '/'
    end
  end

  def applchemNot?
    if (current_user.major != "응용화학과")
      redirect_back(fallback_location: choose_index_path)
      flash[:alert] = "응용화학과 관계자만 접근가능합니다. "
    end
  end

  def feeOfSchoolNot?
    if (current_user.feeOfSchool != true)
          redirect_to index_myinfo_path, method: "get"
          flash[:alert] = "학생회비 미납으로 인하여 사물함을 신청하실 수 없습니다."
    end
  end

  def applyApplchemLocker?
    if current_user.applchemLocker
      redirect_to root_path, method: "get"
      flash[:alert] = "이미 신청하셨습니다."
    end
  end

  def accessOkay?
    if !current_major?
      redirect_to root_path
      flash[:alert] = "해당학과는 이 서비스의 지원을 받지 않습니다."
    end
  end

  def ordinaryUserNot?
  if (current_user.identity == "admin")
    redirect_to root_path
    flash[:alert] = "관리자 계정으로는 사물함 신청이 불가능합니다."
  end
end

  def applchemStudentTimeStart
    if (current_user.identity == "student")
      @currentTime = TimeLimit.find(1).studentTimeStart
    end
  end

  def applchemStudentTimeEnd
    if (current_user.identity == "student")
      @finalTime = TimeLimit.find(1).studentTimeEnd
    end
  end

end
