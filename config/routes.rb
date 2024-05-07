Rails.application.routes.draw do

  
  get '/free_times/get', to: "free_times#get_free_time"
  resources :free_times
  get '/acesso_negado', to: 'error_status#status_403', as: "acesso_negado"
  scope(path_names: { new: 'criar', edit: 'editar' }) do
    
    devise_for :users, path: "usuarios", only: [:sessions, :passwords], path_names: {sign_in: 'entrar', sign_out: 'sair', password: 'senha'}, controllers: { sessions: 'users/sessions'}
    
    resources :users, path: "usuarios"
    patch 'users/:id', to: 'users#ban', as: 'user_ban'

    resources :occurrences, path: "ocorrencias"
    
    #resources :labor_markets
    #resources :labor_markets, only: [:new, :index]
    get '/mercado_de_trabalho/criar', to: 'labor_markets#new', as: 'new_labor_market'
    get '/mercado_de_trabalho', to: 'labor_markets#index', as: 'labor_markets'
    post '/mercado_de_trabalho', to: 'labor_markets#create'
    get '/mercado_de_trabalho/:id', to: 'labor_markets#show', as: 'labor_market'
    get '/mercado_de_trabalho/:id/editar', to: 'labor_markets#edit', as: 'edit_labor_market'
    patch '/mercado_de_trabalho/:id', to: 'labor_markets#update'
    delete '/mercado_de_trabalho/:id', to: "labor_markets#destroy", as: 'destroy_labor_market'
    get '/gerenciamento_mercado_de_trabalho', to: 'labor_markets#page', as: 'page_labor_market'
    resources :labor_markets, except: [:show,:delete,:index,:new,:update,:edit,:create] do
      get :autocomplete_student_name, :on => :collection
    end
    
    # resources :students, path: "alunos"
    get 'alunos/:id/gerar-termo', to: "students#generate_term", as: 'generate_term'
    get 'alunos/relatorio-cpf-csv', to: "students#generate_cpf_csv", as: 'generate_cpf_csv'
    get 'turmas/gerar-certificado-turma', to: 'certification#show_by_classroom', as: 'certification_by_classroom'
    #mostrar historico de alunos renovados
    get 'alunos/alunos-renovados-json/:school_year_id', to: 'students#renewable_students_json', as: 'alunos_renovados_json'
    get 'alunos/alunos-renovados/:school_year_id', to: 'students#renewable_students', as: 'alunos_renovados'
    
    #Gerar pdf do show da entrevista vocacional
    get 'entrevista-profissionalizante/show_pdf/:id', to: 'vocational_interviews#show_pdf', as: 'pdf_show_vocational_interview'
    #Gerar pdf do show da ficha de atendimento
    get 'ficha-de-atendimento/show_pdf/:id', to: 'service_sheets#show_pdf', as: 'pdf_show_service_sheet'
    
    resources :students, path: "alunos" do
      # autocomplete de escola para student
      get :autocomplete_school_name, :on => :collection
      # fichas de atendimento do serviço social
      resources :service_sheets, except: [:index], path: 'fichas-de-atendimento'
      #entrevistas vocaionais
      resources :vocational_interviews, except: [:index], path: 'entrevistas-vocacionais'
      #gerar certificado
      get '/gerar-certificado', to: 'certification#show'
      #mostrar certicados disponíveis
      get '/certificados-disponiveis', to: 'certification#available_certificates'
    end
    
    #get para o index de fichas de atendimento
    get '/fichas-de-atendimento', to: "service_sheets#index", as: 'index_student_service_sheets'
    
    #get para o index de entrevistas vocacionais
    get '/entrevistas-vocacionais', to: "vocational_interviews#index", as: 'index_student_vocational_interviews'
    
    resources :schools, except: :show, path: "escolas"  
    resources :states, except: :show, path: "estados"
    resources :cities, except: :show, path: "cidades"
    resources :neighborhoods, except: :show, path: "bairros"
    post '/programas_assistenciais_de_alunos/', to: "assistance_programs#create_student_program"
    delete '/programas_assistenciais_de_alunos/', to: "assistance_programs#destroy_user_program"
    post '/programas_assistenciais/', to: "assistance_programs#create"
    delete '/programas_assistenciais/', to: "assistance_programs#destroy"
    
    #Serviço Social
    get '/alunos/:id/assistencia-social', to: 'students#social_service', as: 'social_service'
    # resources :vocational_interviews, except: [:index, :new], path: 'entrevistas-vocacionais'
    # get 'alunos/:student_id/entrevistas-vocacionais/criar', to: 'vocational_interviews#new', as: 'new_vocational_interview'
    
    #membros da família
    resources :family_members, path: 'membros_familiares'
    
    #Despesas
    resources :expenses, only: [:create, :destroy], path: 'despesas'
    
    #Relatório de faltas
    resources :absence_reports, only: [:index, :show], path: 'relatorio_de_faltas'
    
    root to: 'static_page#principal'
    
    # Definição das Rotas de Páginas Gerais
    get 'principal', to: "static_page#principal", as: 'main_index'
    get 'financeiro', to: "static_page#financeiro", as: 'financial_index'
    get 'monitoramento', to: 'static_page#monitoring', as: 'monitoring_index'
    get 'academico', to: "static_page#academico", as: 'academic_index'
    get 'secretaria', to: "static_page#secretaria", as: 'secretary_index'
    get 'secretaria/relatorio', to: "static_page#report_secretary", as: 'secretary_report'
    get 'livro-caixa/', to: 'static_page#livro_caixa', as: :cash_book
    get 'servico-social', to: "static_page#servico_social", as: 'social_service_index'
    get 'pedagogo', to: "static_page#pedagogue", as: 'pedagogue_index'
    get 'coordenador', to: "static_page#coordination", as: 'coordination_index'
    get 'gerencia', to: 'static_page#administration', as: 'administration_index'
    
    #Rotas para Relatórios
    get 'relatorios/financeiro', to: "reports#financeiro", as: "financial_reports"
    get 'relatorios/financeiro/gerar', to: "reports#generate_financial_report", as: 'generate_financial_report'
    
    get 'naturezas-transacao/listar-naturezas', to: "financial/transaction_categories#list_transaction_categories", as: "list_transaction_categories"
    get 'contas/listar-contas', to: "financial/accounts#list_accounts", as: "list_accounts"
    get 'classes/listar-classes', to: "financial/organizations#list_organizations", as: "list_organizations"
    get 'empresas/listar-empresas', to: "financial/enterprises#list_enterprises", as: "list_enterprises"
    get 'cidades/listar-cidades', to: "cities#list_cities", as: "list_cities"
    get 'bairros/listar-bairros', to: "neighborhoods#list_neighborhoods", as: "list_neighborhoods"
    get 'escolas/listar-escolas', to: "schools#list_schools", as: "list_schools"
    get '/membros-familiares/listar-familiares', to: "family_members#list_student_relatives", as: "list_relatives"
    get '/assistance_programs/listar-programas', to: "assistance_programs#list_student_programs", as: "list_programs"
    get '/assistance_programs/listar-todos-programas', to: "assistance_programs#list_all_programs", as: "list_all_programs"
    get '/despesas/listar-despesas', to: "expenses#list_student_expenses", as: "list_expenses"
    
    # Rotas para a Area Acadêmica
    scope module: :academic do
      #Relatorio de Faltas (Rota para ação que muda a hora da ultima resolução )
      get '/promote/:id', to: 'classroom_subjects#promote', as: :promote_classroom_subject
      get '/atualizar_data_de_falta_resolvida/:student_id', to: "subject_histories#update_date_resolved_absence", as: "update_date_resolved_absence"
      
      get 'alunos/:student_id/listar-historico', to: 'subject_histories#list_history', as: 'list_history'
      get 'turmas/listar-turmas', to: 'classrooms#list_classrooms', as: 'list_classrooms'
      patch 'turmas/:id/save_all', to: 'classrooms#save_all'
      patch 'turmas/:classroom_id/student_classroom_subject/:id', to: 'student_classroom_subjects#update' 
      
      get 'turmas/:classroom_id/:month/pauta_pdf', to: "classrooms#frequency_list", as: 'pdf_of_frequency_list'
      
      get '/disciplinas/:subject_id/niveis-disciplina/criar', to: 'subject_levels#new', as: 'new_subject_subject_level'
      get 'educadores/:id/painel', to: 'teachers#panel', as: 'teacher_panel'
      get '/educadores/listar-educadores', to: 'teachers#list_teachers', as: "list_teachers"
      get '/educadores/:teacher_id/cursos', to: 'classroom_subjects#index', as: 'teacher_classroom_subjects'
      get '/educadores/:id/disciplinas', to: 'teachers#teacher_subjects', as: 'teacher_subjects'
      get '/educadores/:id/select_disciplinas', to: "teachers#subjects"
      #inscrição
      get '/alunos/:student_id/inscricoes/criar', to: 'inscriptions#new', as: 'new_student_inscription'
      patch 'inscription_inactive/:id', to: 'inscriptions#inactive', as: 'inactive_inscription'
      get '/turmas/:classroom_id/listar-cursos', to: 'classroom_subjects#list_classroom_subjects'
      put 'inscription/:id', to: 'inscriptions#update'
      
      resources :inscriptions, path: 'inscricoes', only: [:create, :update, :destroy]
      resources :teacher_skills, path: 'disciplinas-educador', except: [:index, :show, :edit, :update]
      resources :classrooms, path: 'turmas', except: [:new, :index]
      
      resources :classroom_subjects, path: 'cursos', only: [:show, :create, :destroy]
      get 'educadores/novo_form', to: "teachers#new_form", as: :new_form
      post 'educadores/novo_form', to: "teachers#post_new_form", as: :post_new_form
      
      resources :subjects, path: 'disciplinas'
      resources :subject_levels, path: 'niveis-disciplina', except: [:index, :show, :new]
      resources :teachers, path: 'educadores', except: [:new]
      resources :school_years, path: 'periodos-letivos', except: [:show]
      get ':id/dias-sem-aulas/:current_month', to: "school_years#calendary", as: :no_class
      resources :holidays, path: 'dias-sem-aula', except: [:show, :index, :new]
      resources :lessons, path: 'aulas', except: [:new, :index]
      
      patch '/presencas/:id', to: 'presences#update', as: 'presence'
      
      put '/subject_histories/:id', to: 'subject_histories#update'
      patch '/subject_histories/:id', to: 'subject_histories#update'
      
      
      patch 'teachers/:id', to: 'teachers#disable', as: 'teacher_disable'
      # dias sem aula
      get '/periodos-letivos/:school_year_id/dias-sem-aula', to: 'holidays#index', as: 'school_year_holidays'
      get '/periodos-letivos/:school_year_id/dias-sem-aula/criar', to: 'holidays#new', as: 'new_school_year_holiday'
      
      # Aulas
      patch '/save_all_lesson/', to: 'lessons#save_all'
      get '/cursos/:classroom_subject_id/aulas/:year-:month', to: 'lessons#index', as: 'classroom_subject_lessons'
      get '/cursos/:classroom_subject_id/aulas/criar', to: 'lessons#new', as: 'new_classroom_subject_lesson'
      
      # Período Letivo
      get '/periodos-letivos/:school_year_id/turmas/criar', to: 'classrooms#new', as: 'new_school_year_classroom'
      get '/periodos-letivos/:school_year_id/turmas', to: 'classrooms#index', as: 'school_year_classrooms'
      
      get '/turmas/:classroom_id/cursos/criar', to: 'classroom_subjects#new', as: 'new_classroom_subject'
      get 'cursos/:id/editar', to: 'classroom_subjects#edit',as: 'edit_classroom_subject'
      patch 'cursos/:id', to: 'classroom_subjects#update'
      get '/educadores/:teacher_id/disciplinas-educadores/criar', to: 'teacher_skills#new', as: 'new_teacher_teacher_skill'
      get '/usuarios/:user_id/educadores/criar', to: 'teachers#new', as: 'new_user_teacher'
      
      # Gerar pauta
      get '/cursos/:id/pauta', to: 'classroom_subjects#generate_schedule',as: 'generate_schedule'
      get '/cursos/:id/_pauta', to: 'classroom_subjects#schedule_date',as: 'schedule_date'
      
      #Conselho
      get '/turmas/:id/conselho_de_classe', to: 'classrooms#final_evaluation', as: 'final_evaluation'
      get '/turmas/:id/tabela_de_controle', to: 'classrooms#table_of_secretary', as: 'table_of_secretary'
    end
    
    # Rotas da Área Financeira
    scope module: :financial do
      resources :transactions, path: "transacoes"
      resources :organizations, except: [:show], path: "classes"
      resources :enterprises, except: [:show], path: "empresas"
      resources :accounts, except: [:show], path: "contas-bancarias"
      
      resources :projects, path: "projetos" do
        resources :rubrics, only: [:new], path: "rubricas"
        resources :captations, only: [:new], path: "captacoes"
      end
      resources :rubrics, except: [:new], path: "rubricas"
      resources :captations, except: [:new], path: "captacoes"
      
      resources :rubrics, except: [:index], path: "rubricas" do
        resources :rubric_items, only: [:new], path: "itens-rubrica"
      end
      resources :rubric_items, except: [:new], path: "itens-rubrica"
      
      resources :transaction_categories, except: [:show], path: 'naturezas-transacao'
      
    end
    
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #Monitoring
  get 'periodos-letivos/:id/proxima_turma', to: "monitorings#next_classroom", as: 'generate_next_classroom'
  get 'periodos-letivos/:school_year_id/relatorio-de-resultado-do-conselho', to: "monitorings#school_year_info", as: 'school_year_info'
  get 'periodos-letivos/:school_year_id/conselho_pdf', to: "monitorings#pdf_of_concel", as: 'pdf_of_concel'
  get 'monitoramento/periodo_letivo', to: "monitorings#school_year_monitoring", as: 'monitoring_school_year'
  get 'monitoramento/alunos/relatorio-por-genero-e-faxa-etaria', to: 'monitorings#student_monitoring', as: 'student_monitoring'
  get 'monitoramento/alunos/relatorio-por-tempo-de-permanencia', to: 'monitorings#student_monitoring_individual', as: 'student_individual_monitoring'
  get 'monitoramento/aluno-painel', to: 'monitorings#student_panel', as: "student_monitoring_panel"
  get 'monitoramento/relatorio_quantitativo_de_alunos_atendidos', to: 'monitorings#per_school_year', as: 'monitoring_per_school_year'
  get 'monitoramento/periodo_letivo/conceito_e_avaliacao', to: 'monitorings#concept', as: 'monitoring_concept'
  get 'monitoramento/periodo_letivo/relatorio_de_resultados', to: "monitorings#council", as: 'monitoring_council'
  get 'monitoramento/instrutor/relatorio-de-conceito-e-avaliacao', to: "monitorings#instructor_monitoring", as: 'monitoring_instructor'
  get 'monitoramento/esporte/relatorio-para-ministerio-do-esporte', to: "monitorings#sport_monitoring", as: 'sport_monitoring'
  get 'monitoramento/estatistica_servico_social', to: "monitorings#social_service_monitoring", as: 'monitoring_social_service'
  get 'monitoramento/relatorio-de-taxa-de-ocupação', to: 'monitorings#student_places', as: 'student_places'
  get 'monitoramento/pagina-relatorio-geral', to: "monitorings#page_general_monitoring", as: 'page_general_monitoring'
  get 'monitoramento/relatorio-geral/:school_year_id_one/:school_year_id_two/:school_year_id_three/:school_year_id_four/:general_data/:student_profile/:instructor_monitoring/:council_monitoring/:social_service_monitoring', to: "monitorings#general_monitoring", as: 'general_monitoring'
  
  #Social Service
  get 'servico_social/alunos', to: "social_service#students", as: 'social_service_students'
  get 'entrevistas/nova', to: "interviews#new", as: :new_interview
  get 'servico-social/:user_id/entrevistas', to: "interviews#index", as: :index_interview
  delete 'entrevistas/:id', to: "interviews#destroy", as: :interview_remove
  post 'entrevistas', to: "interviews#create", as: :interview_create
  get 'servico_social/tabela_insercao_mercado', to: "monitorings#monitoring_labor_market_insertion", as: 'table_labor_market_insertion'
  resources :interviews, except: [:show,:destroy,:index,:new,:update,:edit,:create] do
    get :autocomplete_student_name, :on => :collection
  end
  #graficos
  get 'monitoramento/graficos', to: 'grafic#main', as: :grafic
  get 'monitoramento/graficos/tempo_de_permanencia', to: 'grafic#time_stay', as: 'time_stay_grafic'

  get 'monitoramento/graficos/localidade', to: 'grafic#local', as: 'local_grafic'
  get 'monitoramento/graficos/localidade/cidades', to: 'grafic#local_city', as: 'city_local_grafic'
  get 'monitoramento/graficos/localidade/bairro', to: 'grafic#local_neighborhood', as: 'neighbor_local_grafic'
  get 'monitoramento/graficos/periodo_letivo', to: 'grafic#per_school_year_painel', as: 'per_school_year_grafic'
  get 'monitoramento/graficos/periodo_letivo/conceito-e-avaliacao', to: 'grafic#per_school_year', as: 'per_school_year_concept_grafic'
  get 'monitoramento/graficos/periodo_letivo/taxa-de-ocupacao/matriculados', to: 'grafic#student_per_school', as: 'grafic_student_school_year'
  get 'monitoramento/graficos/periodo_letivo/taxa-de-ocupacao/rematriculados', to: 'grafic#student_per_school_re', as: 'grafic_student_per_school_re'
  get 'monitoramento/graficos/periodo_letivo/taxa-de-ocupacao/ativos', to: 'grafic#student_per_school_active', as: 'grafic_student_per_school_active'
  get 'monitoramento/graficos/periodo_letivo/taxa-de-ocupacao/aprovados', to: 'grafic#student_per_school_approved', as: 'grafic_student_per_school_approved'
  get 'monitoramento/graficos/periodo_letivo/taxa-de-ocupacao', to: 'grafic#student_per_school_painel', as: 'grafic_student_per_school_painel'
  get 'monitoramento/graficos/periodo_letivo/distribuicao-por-idade', to: 'grafic#age_distrubution', as: 'age_distrubution'
  get 'monitoramento/graficos/periodo_letivo/distribuicao-por-genero', to: 'grafic#gender_distrubution', as: 'gender_distrubution'
  get 'monitoramento/graficos/periodo_letivo/presenca-geral-por-periodo', to: 'grafic#presence_per_school_year', as: 'presence_per_school_year'
  get 'monitoramento/graficos/periodo_letivo/conceito-diario', to: 'grafic#dairy_concept', as: 'dairy_concept'
  get 'monitoramento/graficos/periodo_letivo/notas-do-aluno', to: 'grafic#student_grade', as: 'student_grade'

end
