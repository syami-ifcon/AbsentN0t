class AdminController < Clearance::SessionsController

  def admin
    
  end

  def admin_panel
  	@lecture = Lecture.all
  end

  def add_teacher
    x = User.create(email: params[:email],name: params[:name],password: params[:password])
    flash[:warning] = "Successfully Create Teacher"
    redirect_to '/admin'
  end

  def add_student
    x = Student.create(first_name: params[:first_name],last_name: params[:last_name],email: params[:email],phone: params[:phone])
    flash[:warning] = "Successfully Create Student"
  end

  def add_subject
    x = Lectures.create(subject_name: params[:subject_name],user_id: params[:user_id],name: params[:name],time: params[:time])
    flash[:warning] = "Successfully Create Subject"
  end

  def dashboard
    now = Date.current
    @x = Attendance.where('DATE(updated_at) = ?', now)
    @lecture_name = []
    @data = []
    Lecture.all.each do |lecture|
      @lecture_name << lecture.name
      @data << Attendance.where("lecture_id = ?",lecture.id).count
    end
  end

  def reported
    @absent = 0
    @notabsent = 0
    @start = params[:start]
    @end = params[:end]
    range = (@end.to_date - @start.to_date ).to_i + 1
    p range
    (@start..@end).each do |date|
      @attendance = Attendance.where('DATE(updated_at) = ? AND lecture_id = ?', date, params[:lecture_id])
      @attendance.each do |x|
        if x.present == true
          @notabsent += 1
        else
          @absent += 1
        end
      end
    end
  end

end