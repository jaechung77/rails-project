class EnrolmentsController < ApplicationController
  before_action :set_enrolment, only: %i[ show edit update destroy ]

  # GET /enrolments or /enrolments.json
  def index
    if helpers.is_admin?
      @enrolments = Enrolment.all    
    else  
      @enrolments = Enrolment.all.where("student_id=?", params[:student_id])
    end  
  end

  # GET /enrolments/1 or /enrolments/1.json
  def show

  end

  # GET /enrolments/new
  def new
    if !user_signed_in?
      redirect_to new_user_session_path
    end  
    @enrolment = Enrolment.new
    @teachings = Teaching.where.not(id: Enrolment.joins(:teaching).select(:teaching_id).where("student_id=?", params[:student_id]))
    @subjects = Subject.all
  end

  # GET /enrolments/1/edit
  def edit
  end

  # POST /enrolments or /enrolments.json
  def create
    params[:enrolment][:teaching_ids].each do |teaching_id|
      @enrolment = Enrolment.new
      @enrolment.student_id = Student.find_by("user_id=?", current_user.id).id
      @enrolment.teaching_id = teaching_id
      @enrolment.save
    end  

  redirect_to student_enrolments_path @enrolment.student_id

  # render :new

  end

  # PATCH/PUT /enrolments/1 or /enrolments/1.json
  def update
    respond_to do |format|
      if @enrolment.update(enrolment_params)
        format.html { redirect_to @enrolment, notice: "Enrolment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrolment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrolment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolments/1 or /enrolments/1.json
  def destroy
    @enrolment.destroy
    respond_to do |format|
      format.html { redirect_to student_enrolments_path(Student.find_by("user_id=?", current_user.id).id), notice: "Enrolment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrolment
      @enrolment = Enrolment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrolment_params
      params.require(:enrolment).permit(
                                        :student_id,
                                        :teaching_ids => [] 
                                      )
    end
end

