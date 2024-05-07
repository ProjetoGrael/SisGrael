class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    alias_action :edit, :to => :update
    if !user.nil?
      can [:read, :update, :destroy], User, id: user.id
      cannot :index, User
    end

    if user.admin?
      can :manage, :all
    end

    if user.financial?
      can :manage, [
        Financial::Account,
        Financial::Captation,
        Financial::Institution,
        Financial::Project,
        Financial::RubricItem,
        Financial::Rubric,
        Financial::Transaction,
        Financial::TransactionCategory
      ]
      can :manage, :financial
    end

    if user.secretary?
      can :frequency_list , Academic::Classroom
      can :available_certificates, :certification
      cannot :destroy, Academic::ClassroomSubject
      can [:read, :calendary], Academic::SchoolYear
      can :manage, [
        Student,
        Occurrence,
        :secretary,
        Academic::Inscription,
        Academic::TeacherSkill,
        Academic::Classroom,
        Academic::ClassroomSubject,
        Academic::Subject  
      ]
      can [
        :index,
        :panel,
        :show, 
        :subjects, 
        :list_teachers
      ], Academic::Teacher
    end

    if user.social_service?
      can :manage, [
        Student,
        VocationalInterview,
        ServiceSheet,
        LaborMarket,
        :social_service,
        :secretary,
        Academic::SchoolYear,
        Academic::ClassroomSubject,
        Academic::Classroom

      ]
      can [:read, :create], Occurrence
      can :read, [:servico_social, Academic::Lesson]
      can [:subjects, :list_teachers], Academic::Teacher
    end

    if user.instructor?
      teacher_id = user.teacher.id if user.teacher.present?
      can :manage, [user.teacher, user]
      can :read, Student
      can :show, Academic::Subject
      can :calendary, Academic::SchoolYear
      can [:show, :read, :frequency_list], Academic::Classroom
      can [:read, :schedule_date], Academic::ClassroomSubject, teacher_id: teacher_id
      can [:update, :read, :save_all], Academic::Lesson, classroom_subject: {teacher_id: teacher_id}
      can [
        :create, 
        :update, 
        :show, 
        :panel, 
        :teacher_subjects
      ], Academic::Teacher, id: teacher_id
    end
    
    if user.pedagogue?
      can :create, Academic::Holiday
      can [:read, :create], Occurrence
      can :update,Academic::SubjectHistory
      can :available_certificates, :certification
      can :read, [Academic::Presence, Academic::Lesson]
      can :manage, [
        Student,
        Academic::SchoolYear,
        Academic::Subject,
        :social_service,
        :VocationalInterview
      ]
      can [
        :read, 
        :generate_schedule, 
        :create, 
        :promote
      ], Academic::ClassroomSubject
      can [
        :index, 
        :show, 
        :list_teachers, 
        :panel, 
        :update,
        :new_form,
        :subjects
      ], Academic::Teacher
      can [
        :index, 
        :show, 
        :create, 
        :destroy, 
        :save_all, 
        :show_counsel, 
        :update_counsel, 
        :frequency_list, 
        :final_evaluation
      ], Academic::Classroom
    end

    if user.coordination?
      can :create, Academic::Holiday
      can [:read, :create], Occurrence
      can :update, Academic::SubjectHistory
      can :available_certificates, :certification
      can :read, [Academic::Presence, Academic::Lesson]
      can :manage, [
        Student,
        Academic::Inscription, 
        Academic::SchoolYear, 
        Academic::Subject, 
        :social_service, 
        :VocationalInterview
      ]
      can [
        :read, 
        :generate_schedule, 
        :create, 
        :promote
      ], Academic::ClassroomSubject
      can [
        :index, 
        :show, 
        :list_teachers, 
        :panel, 
        :update, 
        :new_form, 
        :subjects
      ], Academic::Teacher
      can [
        :index, 
        :show, 
        :create, 
        :update, 
        :destroy, 
        :save_all, 
        :show_counsel, 
        :update_counsel, 
        :frequency_list, 
        :final_evaluation
      ], Academic::Classroom
    end

    if user.administration?
      can :manage, [
        Financial::Account,
        Financial::Captation,
        Financial::Institution,
        Financial::Project,
        Financial::RubricItem,
        Financial::Rubric,
        Financial::Transaction,
        Financial::TransactionCategory
      ]
      can :read, :financial
    end
    
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    
    #   can :update, Article, :published => true
    
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
