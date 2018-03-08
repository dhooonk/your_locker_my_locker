class AdminController < ApplicationController
    # before_action :authenticate_user!
    # before_action :adminNot?
    before_action :authenticate_user!
    before_action :adminNot?

    def index
      @head = true
      if params[:order].nil?
        if (current_user.major == "응용화학과") ## 응용화학과일때,
          @user_admin = User.where(major: userMajor?).order('studentNumber ASC')
        end
      else
        if userMajor? == "응용화학과"
          if params[:order]== '사물함(학과) 순'
            @user_admin = User.where(major: userMajor?).includes(:applchemLocker).order('applchemLocker.lockerNumber ASC')
          elsif params[:order]== '학번 순'
            @user_admin = User.where(major: userMajor?).order('studentNumber ASC')
          elsif params[:order] == '이름 순'
            @user_admin = User.where(major: userMajor?).order('name ASC')
          elsif params[:order] == '납부 순'
            @user_admin = User.where(major: userMajor?).order('feeOfSchool ASC')
          elsif params[:order] == '권한 순'
            @user_admin = User.where(major: userMajor?).order('identity DESC')
          end
        end
      end
    end

    def feeOfSchool
      user = User.find(params[:id])
      if user.feeOfSchool == true
        user.feeOfSchool = "false"
        user.save
      else
        user.feeOfSchool = "true"
        user.save
      end
      redirect_to admin_index_path, method:"get"
    end

    def edit
      user=User.find(params[:id])
      user.password='123456'
      user.password_confirmation='123456'
      user.save
      flash[:warning] = "'#{user.name}'사용자의 계정(#{user.studentNumber}) 비밀번호가 변경되었습니다."
      redirect_to admin_index_path
    end

  def time
    if current_user.major == "응용화학과"
      @limit = TimeLimit.find(1)
      @limit_id = 1
    end
  end


  def update
    @limit = TimeLimit.find(params[:id])

    if params[:studentTimeStart].nil?
      @limit.studentTimeStart = (Time.now + 100000000)
    else
      if params[:studentTimeStart].length != 16
        @limit.studentTimeStart = (Time.now + 100000000)
      else
        limit = params[:studentTimeStart]
        @limit.studentTimeStart = "#{limit} +0900"
      end
    end

    if params[:studentTimeEnd].nil?
      @limit.studentTimeEnd = (Time.now + 110000000)
    else
      if params[:studentTimeEnd].length != 16
        @limit.studentTimeEnd = (Time.now + 110000000)
      else
        limit = params[:studentTimeEnd]
        @limit.studentTimeEnd = "#{limit} +0900"
      end
    end

    if @limit.save
    redirect_to edit_admin_path(params[:id]), method: "get"
    flash[:success] = "신청기간 설정을 완료하였습니다."
    else
    redirect_to edit_admin_path(params[:id]), method: "get"
    flash[:alert] = "신청기간 설정에 실패했습니다. 양식에 맞춰 작성해주세요."
    end

  end
end
