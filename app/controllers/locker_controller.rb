class LockerController < ApplicationController

    def applchem
      @lockers = ApplchemLocker.all
      # 행           열 #
      number_one = ["01", "02", "03", "04"]
      number_two = ["05", "06", "07", "08"]
      number_thr = ["09", "10", "11", "12"]
      number_fou = (13..16)
      number_fiv = (17..20)
      @number = [number_one, number_two, number_thr, number_fou, number_fiv]
      number_one_dif = ["01", "02"]
      number_two_dif = ["03", "04"]
      number_thr_dif = ["05", "06"]
      number_fou_dif = ["07", "08"]
      number_fiv_dif = ["09", "10"]
      @number_dif = [number_one_dif, number_two_dif, number_thr_dif, number_fou_dif, number_fiv_dif]
    end

    def create
      if current_user.major == "응용화학과"
          if params[:major] == "응용화학과"
            if ApplchemLocker.find_by(lockerNumber: params[:lockerNum])
              redirect_to applchem_path, method:"get"
              flash[:alert] = "이미 신청완료 된 사물함입니다."
            else
              ApplchemLocker.create(lockerNumber: params[:lockerNum], major: current_user.major, user_id: current_user.id)
              redirect_to root_path, method: "get"
              flash[:success] = "#{params[:seatNumber]}번 사물함이 신청되었습니다."
            end
          end
      end
    end

    def destroy_applchem

    applchemLocker = ApplchemLocker.find_by(user_id: params[:id])
    applchemLocker.destroy
    redirect_to root_path

    flash[:warning] = "사물함이 취소되었습니다."
  end

end