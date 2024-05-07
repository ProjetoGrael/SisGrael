$(
  () => {
      if ($("#final-evaluation")) {
          const saveButton = $(".save-button");
          const handleClick = async (event) => {
              
              event.preventDefault();
              const authTok = document.getElementById("authenticity_token").value;
              const aroundTr = event.target.parentNode.parentNode;
              const inscription_id = aroundTr.getElementsByClassName("inscription_id")[0].value;
              
              const presence = aroundTr.getElementsByClassName("presence");
              const justified_absences = aroundTr.getElementsByClassName("justified-absence");
              const partial_counsel = aroundTr.getElementsByClassName("partial-council");
              const final_counsel = aroundTr.getElementsByClassName("final-council")
              const subject_history_id = aroundTr.getElementsByClassName("subject_history_id")
              
              
              const counsel_opinion = aroundTr.getElementsByClassName("council-opinion")[0].value;
              const situation = aroundTr.getElementsByClassName("situation")[0].querySelector("select").value;
              


              
              const data =     {
                  inscription: {
                      
                      counsel_opinion: counsel_opinion,
                      situation: situation,

                  },
          
                  authenticity_token: authTok 
              }
              
              console.log(`sending ${data}`);
              
              const url = '/inscription/' + inscription_id 

              
              const response = await fetch(url,
                  {
                      method: 'put',
                      headers: {
                          'Accept': 'application/json',
                          'Content-Type': 'application/json'
                      },
                      body: JSON.stringify(data)
                  }

              )

              console.log(response); 
              
              if (response.status === 200) {
                  const savedObject = await response.json();
                  console.log(savedObject);
                  alert("Informação do conselho da turma salvo.");
              }else if (response.status === 422) {
                  const errorArray = await response.json();
                  alert(errorArray);
              }
              
              for (let i = 0;i < subject_history_id.length;i++){
                let subject_histories_id_to_send = subject_history_id[i].value
                let subject_history_url = '/subject_histories/'+ subject_histories_id_to_send
                console.log(subject_history_id)
                let presence_to_send = presence[i].innerText
                let justified_absences_to_send = justified_absences[i].innerText
                let partial_counsel_to_send = partial_counsel[i].querySelector("select").value
                let final_counsel_to_send = final_counsel[i].querySelector("select").value
                let test = presence_to_send.slice(0, presence_to_send.length-1)
                // alert(subject_history_url)
                let data_to_send =     {
                  subject_history: {
                      
                      
                    presence: test,
                    justified_absences: justified_absences_to_send,
                    partial_counsel: partial_counsel_to_send,
                    final_counsel: final_counsel_to_send,

                  },
          
                  authenticity_token: authTok 
                }
                const response_to_confirm = await fetch(subject_history_url,
                  {
                      method: 'put',
                      headers: {
                          'Accept': 'application/json',
                          'Content-Type': 'application/json'
                      },
                      body: JSON.stringify(data_to_send)
                  })
                  console.log(response_to_confirm); 
              
              if (response_to_confirm.status === 200) {
                  let savedObject_to_confirm = await response_to_confirm.json();
                  console.log(savedObject_to_confirm);
                  
              }else if (response.status === 422) {
                  const errorArray = await response.json();
                  alert(errorArray);
              }
              }
              
              
          }

          saveButton.click(
              (event) => {
                  handleClick(event)
              } 
          )
      }
  }
)