
// const classroomSelect = document.querySelector("#inscription_classroom_select");
// const divForm = document.querySelector('#inscription_classroom_fields');
// const div = document.createElement('div')
// div.innerHTML = '<input type="submit" name="commit" value="Realizar Inscrição" data-disable-with="Realizar Inscrição" class = "generate-button">';

// classroomSelect.addEventListener('change', (e) => {
//     id = e.target.value
//     divForm.innerHTML = ""
    
//     const token = document.querySelector("#my_authenticity_token").value;
//     $.ajax({
//       headers: {
//         Accept: "application/json",
//         "Content-Type": "application/json",
//       },
//       url: `/turmas/${id}/listar-cursos`,
//       type: "GET",
//       data: JSON.stringify({
//         authenticity_token: token,
//       }),
//     })
//       .then((res) => {
//         const input = document.createElement("input");
//         input.type = "hidden";
//         input.name = "inscription[classroom_id]";
//         input.value = id;
//         res.map((course) => {
//           const p = document.createElement("p");
//           p.innerHTML = `<p>${course[0]}</p>`;

//           const select = document.createElement("select");
//           select.name = `inscription[classroom_subjects][${course[2]}][subject_level_id]`;
//           course[1].map((level) => {
//             const op = document.createElement("option");
//             op.value = level[1];
//             op.innerHTML = level[0];
//             select.appendChild(op);
//           });
//           divForm.append(p);
//           divForm.append(select);
//         });
//         divForm.append(input);
//         divForm.append(div);
//       })
//       .catch(console.log);
// });