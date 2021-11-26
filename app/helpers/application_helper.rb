module ApplicationHelper
    def is_admin?
        if User.find(current_user.id).is_admin == TRUE
            return TRUE
        end
    end

    def login_user_name
        if is_admin?
            return "Admin"
        elsif current_user &&  !Student.find_by("user_id=?", current_user.id) 
            return current_user.email
        elsif  current_user &&  Student.find_by("user_id=?",  current_user.id) 
            return Student.find_by("user_id=?",  current_user.id).first_name
        end    
    end  
    
    def get_student_id
        if user_signed_in?
            if Student.find_by("user_id=?",  current_user.id)
                Student.find_by("user_id=?",  current_user.id).id
            else
                0
            end        
        end    
    end    
end
