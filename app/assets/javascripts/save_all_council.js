function get_select (class_name, index) {
  let select = document.querySelectorAll(class_name)[index];
  if (select.classList.contains("evaded")) return select;
  else return select.children[select.selectedIndex];
}

function inscription_object (index) {
  const inscription_id = document.querySelectorAll('.inscription_id')[index].value;
  const counsel_opinion = document.querySelectorAll('.council-opinion')[index].value;
  const situation = get_select('.situation', index).value;

  const select = get_select('.next_level', index);

  const subject_id = select.getAttribute("subject_id");
  const subject_level_id = select.getAttribute("subject_level_id"); 

  const data = {
    inscription_id: inscription_id,
    params: {
      counsel_opinion: counsel_opinion,
      situation: situation,
      subject_level_id: subject_level_id,
      subject_id: subject_id
    }
  }
  return data;
}

function get_inscriptions () {
  const inscription_length = document.getElementById("inscription_length").value;
  const inscriptions = [];

  for (let i = 0; i < inscription_length; i++) {
    inscriptions.push(inscription_object(i));
  }
  return inscriptions;
}


function subject_history_object (index) {
  const subject_history_id = document.querySelectorAll('.subject_history_id')[index].value;
  const presence_text = document.querySelectorAll('.presence')[index].innerText;
  const justified_absence = document.querySelectorAll('.justified-absence')[index].innerText;

  const partial_counsel = get_select('.partial-council', index).value; 
  const final_counsel = get_select('.final-council', index).value;
  
  const presence = presence_text.slice(0, presence_text.length - 1);

  const data = {
    subject_history_id: subject_history_id,
    params: {
      presence: presence,
      justified_absences: justified_absence,
      partial_counsel: partial_counsel,
      final_counsel: final_counsel,
    }
  };
  return data;
}

function get_subject_histories () {
  const subject_history_ids = document.querySelectorAll('.subject_history_id');
  const subject_histories = [];
  
  for (let i = 0; i < subject_history_ids.length; i++) {
    subject_histories.push(subject_history_object(i));
  }
  return subject_histories;
}


function send_request (data) {
  const url = 'save_all';
  $.ajax({
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    url: url,
    type: 'PATCH',
    data: data,
    success: () => alert("Todos dados salvos com sucesso"),
    error: () => alert("Ocorreu um problema ao salvar os dados")
  });
}

$(document).ready(() => {
  
  $('#save_all_counsel').click(() => {
    const inscriptions = get_inscriptions();
    const subject_histories = get_subject_histories();
    const token = document.getElementById("authenticity_token").value;
    const class_opinion = document.getElementById("classroom_opinion").value;
    const data = {
      inscriptions: inscriptions,
      subject_histories: subject_histories,
      class_opinion: class_opinion,
      authenticity_token: token,
    }
    send_request(JSON.stringify(data));
  });
});