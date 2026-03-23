// document.getElementById('b2').addEventListener('click', function() {
//         ym(29995129, 'reachGoal', 'mpnu-pdf');
//     });

// src="https://cdn.jsdelivr.net/npm/chart.js"
// src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-1.9.0.min.js"
    var name1 = "";
    function updatePdfLink() {
        const key_mpny=document.getElementById('key_mpny').value;
        const link = document.getElementById('pdf-link');
        const baseUrl = 'generate_pdf';  // Django подставит URL на сервере
        //  url: 'generate_pdf',
        link.href = baseUrl + "?name=" + encodeURIComponent(name1)+"&key_mpny="+encodeURIComponent(key_mpny);
    }
    /* var name1 = "" */
    /*const imgData = ""*/
    /*function updatePdfLink() {*/

    /*  const link = document.getElementById('pdf-link');*/
    /* link.href = `{% url 'generate_pdf' %}?name=${encodeURIComponent(name1)}`;*/

    /* }*/

    function wind() {
        const dialog = document.getElementById('modal');
        let All = document.getElementById('All');
        let MasDaf = document.getElementById('MasDaf');
        let Lubi = document.getElementById('Lubi');
        let CNP = document.getElementById('CNP');
        let Hydroo = document.getElementById('Hydroo');
        let Other = document.getElementById('Other');
        
        // Проверяем, что все чекбоксы сняты
        let allUnchecked = !All.checked && !MasDaf.checked  && !CNP.checked && !Hydroo.checked && !Other.checked;
        
        if (allUnchecked) {
            // Если все сняты — диалог не открываем или сразу закрываем
            if (dialog.open) {
                dialog.close();
                
            }
            const elem1 = document.querySelector('.container.TY-Text1');
            const elem2 = document.getElementById('TY3');
            const elem3 = document.getElementById('TY');
            const elem4 = document.getElementById('b2');
            /*const elem5 = document.querySelector('.tab_prod');*/
            if (elem1) elem1.style.visibility = 'hidden';
            if (elem2) elem2.style.visibility = 'hidden';
            if (elem3) elem3.style.visibility = 'hidden';
            if (elem4) elem4.style.visibility = 'hidden';
            /*if (elem5) elem5.style.visibility = 'hidden';*/
            return; // Выходим из функции, не показывая диалог
            
        }
        dialog.showModal();
        document.getElementById('close').onclick = () => dialog.close();
    }

    function JOK() {

        const jok_bool = document.getElementById('jok_bool');

        const H_jok = document.getElementById('H_jok');
        const form1 = document.getElementById('form1');
        const H = document.getElementById('H').value;
        const Q_jok = document.getElementById('Q_jok');
        const H_jok_e = document.getElementById('H_jok_e');
        const Q_jok_e = document.getElementById('Q_jok_e');
        const row7 = document.getElementById('row7');
        const row8 = document.getElementById('row8');

        const Q_jok_label = document.querySelector('label[for="Q_jok"]');
        const H_jok_label = document.querySelector('label[for="H_jok"]');
        if (jok_bool.checked) {
            row7.style.display = 'table-row';
            row8.style.display = 'table-row';
            H_jok_e.style.display = 'table-cell';
            Q_jok_e.style.display = 'table-cell';
            H_jok.style.display = 'inline';
            Q_jok.style.display = 'inline';
            Q_jok_label.style.display = 'inline';
            H_jok_label.style.display = 'inline';
            form1.style.height = 'auto';
            if (H_jok.value == 0) {
                H_jok.value = parseFloat(H) + 5;
            }

            if (Q_jok.value == 0) {
                Q_jok.value = 3;
            }

        }
        else {
            row7.style.display = 'none';
            row8.style.display = 'none';
            H_jok_e.style.display = 'none';
            Q_jok_e.style.display = 'none';
            H_jok.style.display = 'none';
            Q_jok.style.display = 'none';
            Q_jok_label.style.display = 'none';
            H_jok_label.style.display = 'none';
            /*form1.style.height = 'auto';*/
        }
    }

    function only_ist() {
        const IST = document.getElementById('istochik').value;
        //const IST_H_value = parseFloat(document.getElementById('IST_H').value);
        //const IST_V_value = parseFloat(document.getElementById('IST_V').value);
        const IST_H_value = document.getElementById('IST_H').value;
        const IST_V_value = document.getElementById('IST_V').value;

        if (IST == "v") {

            document.getElementById('IST_H').style.display = 'none';

            document.getElementById('IST_H_tr').style.display = 'none';
            document.getElementById('IST_V_tr').style.display = 'table-row';
            //document.getElementById('IST_H_tr2').style.display = 'none';
            //document.getElementById('IST_V_tr2').style.display = 'table-row';
            document.getElementById('IST_V').style.display = 'table-row';

            //document.getElementById('IST_H_e').style.display = 'none';
            //document.getElementById('IST_V_e').style.display = 'inline';

            document.querySelector('label[for="IST_H"]').style.display = 'none'
            document.querySelector('label[for="IST_V"]').style.display = 'table-row';
        }
        else if (IST == "r_up" && IST_H_value >= 0) {
            document.getElementById('IST_H').style.display = 'table-row'
            document.getElementById('IST_V').style.display = 'none';
            //document.getElementById('IST_H_e').style.display = 'inline'
            //document.getElementById('IST_V_e').style.display = 'none';
            document.getElementById('IST_H_tr').style.display = 'table-row';
            document.getElementById('IST_V_tr').style.display = 'none';
            //document.getElementById('IST_H_tr2').style.display = 'table-row';
            //document.getElementById('IST_V_tr2').style.display = 'none';

            document.querySelector('label[for="IST_H"]').style.display = 'table-row'
            document.querySelector('label[for="IST_V"]').style.display = 'none';
        }
        else if (IST == "r_up" && IST_H_value < 0) {


            document.getElementById('IST_H_tr').style.display = 'table-row';
            document.getElementById('IST_V_tr').style.display = 'none';

            //document.getElementById('IST_H_tr2').style.display = 'table-row';
            //document.getElementById('IST_V_tr2').style.display = 'none';

            document.getElementById('IST_H').style.display = 'table-row'
            document.getElementById('IST_V').style.display = 'none';
            //document.getElementById('IST_H_e').style.display = 'inline'
            //document.getElementById('IST_V_e').style.display = 'none';
            document.querySelector('label[for="IST_H"]').style.display = 'table-row'
            document.querySelector('label[for="IST_V"]').style.display = 'none';
        }
    }
    window.onload = function () {
        document.getElementById('All').checked = true;
        obr('All');
    };
    function obr(satus) {

        let All = document.getElementById('All');
        let MasDaf = document.getElementById('MasDaf');
        let Lubi = document.getElementById('Lubi');
        let CNP = document.getElementById('CNP');
        let Hydroo = document.getElementById('Hydroo');
        let Other = document.getElementById('Other');

        let allChecked = All.checked;
        let masDafChecked = MasDaf.checked;
        let lubiChecked = Lubi.checked;
        let cnpChecked = CNP.checked;
        let hydrooChecked = Hydroo.checked;
        let otherChecked = Other.checked;

        if (satus == "All" && allChecked == true) {
            MasDaf.checked = true;
            Lubi.checked = true;
            CNP.checked = true;
            Hydroo.checked = true;
            Other.checked = true;
        }
        if (satus == "All" && allChecked == false) {
            MasDaf.checked = false;
            Lubi.checked = false;
            CNP.checked = false;
            Hydroo.checked = false;
            Other.checked = false;
        }
        if (satus == "var") {
            All.checked = false;

        }
        if (satus == "var") {
            All.checked = MasDaf.checked && Lubi.checked && CNP.checked && Hydroo.checked && Other.checked;
        }
        document.getElementById('sort_id').click();

    }
    function sort(event) {
        let All = document.getElementById('All').checked;
        let MasDaf = document.getElementById('MasDaf').checked;
        let Lubi = document.getElementById('Lubi').checked;
        let CNP = document.getElementById('CNP').checked;
        let Hydroo = document.getElementById('Hydroo').checked;
        let Other = document.getElementById('Other').checked;
        const type = event.target.value;
        const select = document.getElementById("pump-select");
        
        // Получение CSRF-токена из cookie (для Django)
        function getCookie(name) {
            let cookieValue = null;
            if (document.cookie && document.cookie !== '') {
                const cookies = document.cookie.split(';');
                for (let i = 0; i < cookies.length; i++) {
                    const cookie = cookies[i].trim();
                    // Проверяем, начинается ли cookie с нужного имени
                    if (cookie.substring(0, name.length + 1) === (name + '=')) {
                        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                        break;
                    }
                }
            }
            return cookieValue;
        }
        const key_mpny=document.getElementById('key_mpny').value;
        const csrftoken = getCookie('csrftoken');
        $.ajax({
            type: 'POST',
            url: 'Sort/',  // URL представления get_data
            data: {
                variable: type,
                Other: Other,
                Hydroo: Hydroo,
                CNP: CNP,
                Lubi: Lubi,
                MasDaf: MasDaf,
                key_mpny: key_mpny,

            },
            headers: { 'X-CSRFToken': csrftoken },  // Добавляем CSRF-токен в заголовки
            success: function (data) {
                select.innerHTML = '';
                for (const [value, text] of Object.entries(data)) {
                    const option = document.createElement('option');
                    option.value = value;
                    option.textContent = text;
                    select.appendChild(option);
                }
                select.click();
            }
        });
    }

    function rescount() {
        const Q = document.getElementById('Q').value;
        /*        const istochik = document.getElementById('istochik').value;*/
        let istochik = 0;
        const IST = document.getElementById('istochik').value;
        //const IST_H_value = parseFloat(document.getElementById('IST_H').value);
        //const IST_V_value = parseFloat(document.getElementById('IST_V').value);
        const IST_H_value = document.getElementById('IST_H').value;
        const IST_V_value = document.getElementById('IST_V').value;
        if (IST == "v") {
            document.getElementById('IST_H').style.display = 'none'
            document.getElementById('IST_V').style.display = 'inline';
            document.querySelector('label[for="IST_H"]').style.display = 'none'
            document.querySelector('label[for="IST_V"]').style.display = 'inline';
            istochik = 2.8;
            //document.getElementById('IST_H_e').style.display = 'none';
            //document.getElementById('IST_V_e').style.display = 'inline';

            document.getElementById('IST_H_tr').style.display = 'table-row';
            document.getElementById('IST_V_tr').style.display = 'inline';
            //document.getElementById('IST_H_tr2').style.display = 'table-row';
            //document.getElementById('IST_V_tr2').style.display = 'inline';
        }
        else if (IST == "r_up" && IST_H_value >= 0) {
            document.getElementById('IST_H').style.display = 'inline'
            document.getElementById('IST_V').style.display = 'none';
            document.querySelector('label[for="IST_H"]').style.display = 'inline'
            document.querySelector('label[for="IST_V"]').style.display = 'none';
            istochik = 2.8;

            //document.getElementById('IST_H_e').style.display = 'inline'
            //document.getElementById('IST_V_e').style.display = 'none';
            document.getElementById('IST_H_tr').style.display = 'table-row';
            document.getElementById('IST_V_tr').style.display = 'none';
            //document.getElementById('IST_H_tr2').style.display = 'table-row';
            //document.getElementById('IST_V_tr2').style.display = 'none';
            /*alert(IST_H_value);*/
        }
        else if (IST == "r_up" && IST_H_value < 0) {
            document.getElementById('IST_H').style.display = 'inline'
            document.getElementById('IST_V').style.display = 'none';
            document.querySelector('label[for="IST_H"]').style.display = 'inline'
            document.querySelector('label[for="IST_V"]').style.display = 'none';
            istochik = 1.5;
            //document.getElementById('IST_H_e').style.display = 'inline'
            //document.getElementById('IST_V_e').style.display = 'none';
            document.getElementById('IST_H_tr').style.display = 'table-row';
            document.getElementById('IST_V_tr').style.display = 'none';
            //document.getElementById('IST_H_tr2').style.display = 'table-row';
            //document.getElementById('IST_V_tr2').style.display = 'none';
        }
        const DN_in = document.getElementById('DN_in');
        const DN_out = document.getElementById('DN_out');
        const DN = [50, 65, 80, 100, 125, 150, 200, 250, 300, 350, 400, 450, 500];
        DN_in.innerHTML = '';
        DN_out.innerHTML = '';
        const DN_in_sp = [];
        const DN_out_sp = [];
        for (let i = 0; i < DN.length; i++) {
            var Speed = (Q / 3600) / ((DN[i] / 1000) * (DN[i] / 1000) * 3.14 / 4)
            if (Speed <= istochik) {
                DN_in.add(new Option("DN " + DN[i], DN[i]));
                DN_in_sp.push(DN[i]);

            }
            if (Speed <= 10) {
                DN_out.add(new Option("DN " + DN[i], DN[i]));
                DN_out_sp.push(DN[i]);

            }

        }

        document.getElementById('DN_out_sp').value = JSON.stringify(DN_out_sp);
        document.getElementById('DN_in_sp').value = JSON.stringify(DN_in_sp);



    }
    function resetResults() {

        const elem1 = document.querySelector('.container.TY-Text1');
        const elem2 = document.getElementById('TY3');
        const elem3 = document.getElementById('TY');
        const elem4 = document.getElementById('b2');
        const elem5 = document.querySelector('.tab_prod');
        //const elem5 = document.getElementById('tab_prod');
        if (elem1) {elem1.style.visibility = 'hidden';}
        if (elem2) {elem2.style.visibility = 'hidden';}
        if (elem3) {elem3.style.visibility = 'hidden';}
        if (elem4) {elem4.style.visibility = 'hidden';}
        if (elem5) {elem5.style.visibility = 'hidden';}
    }
    document.addEventListener('DOMContentLoaded', function () {



        const Q = document.getElementById('Q');
        const H = document.getElementById('H');
        const istochik = document.getElementById('istochik');
        const jok_bool = document.getElementById('jok_bool');
        const IST_H_value = document.getElementById('IST_H');
        const form1 = document.getElementById('form1');
        const table = document.querySelector('.pred-param2');
        if (jok_bool.checked) { const t = 9; }
        else {
            const H_jok = document.getElementById('H_jok').style.display = 'none';
            const Q_jok = document.getElementById('Q_jok').style.display = 'none';
            const Q_jok_label = document.querySelector('label[for="Q_jok"]');
            const H_jok_label = document.querySelector('label[for="H_jok"]');
            //const H_jok_e = document.getElementById('H_jok_e');
            //const Q_jok_e = document.getElementById('Q_jok_e');
            Q_jok_label.style.display = 'none';
            H_jok_label.style.display = 'none';
            H_jok_e.style.display = 'none';
            Q_jok_e.style.display = 'none';
            /*          document.getElementById('IST_H').style.display = 'none'*/
            //document.getElementById('IST_V').style.display = 'none';
            //document.getElementById('IST_V_e').style.display = 'none';
            ///*      document.querySelector('label[for="IST_H"]').style.display = 'none'*/
            //document.querySelector('label[for="IST_V"]').style.display = 'none';
        }
        if (jok_bool) {
            jok_bool.addEventListener('change', function (event) {
                JOK();
            });
        }
        if (Q) {
            Q.addEventListener('change', function (event) {
                rescount();
                only_ist();//добавил тут
            });
        }
        if (H) {
            H.addEventListener('change', function (event) {
                JOK();
            });
        }
        if (istochik) {
            istochik.addEventListener('change', function (event) {
                rescount();
                only_ist();
            });


        }
        if (IST_H_value) {
            IST_H_value.addEventListener('change', function (event) {
                rescount();
                only_ist();
            });


        }
        //if (form1) {
            //form1.addEventListener('input', resetResults);
            //form1.addEventListener('change', resetResults);
       // }
        if (table) {
                table.addEventListener('change', function(event) {
                    const target = event.target;
                    // Проверяем, что событие произошло на input, select или textarea внутри таблицы
                    if (target.matches('input, select, textarea')) {
                        // Ваша функция, которая будет вызываться при изменении
                        resetResults();
                       
                    }
    });
}
       




        only_ist();
        JOK();
    });
    document.addEventListener('DOMContentLoaded', function () {
        const pump = document.getElementById('pump-select');

        if (pump) {
            pump.addEventListener('click', function (event) {
                const selectedPump = event.target.value;
                if (selectedPump == "") { wind(); }
                only_ist();
                CHART(selectedPump);
                if (selectedPump != "") {
                    //const elem1 = document.querySelector('.container.TY-Text1');
                    const elem2 = document.getElementById('TY3');
                    const elem3 = document.getElementById('TY');
                    //const elem4 = document.getElementById('b2');
                    /*const elem5 = document.querySelector('.tab_prod');*/
                    //if (elem1) elem1.style.visibility = 'visible';
                    if (elem2) elem2.style.visibility = 'visible';
                    if (elem3) elem3.style.visibility = 'visible';
                    //if (elem4) elem4.style.visibility = 'visible';
                    /*if (elem5) elem5.style.visibility = 'hidden';*/
                }



            });
        }
        pump.click();
    });
    let myChart = null; // Для хранения экземпляра графика
    let ctx = null;
    var name;
    function CHART(name) {
        let Q = null;  // Данные для Q
        let H = null;
        let Qgl = null;
        let Hgl = null;
        name1 = name

        function getCookie(name) {
            let cookieValue = null;
            if (document.cookie && document.cookie !== '') {
                const cookies = document.cookie.split(';');
                for (let i = 0; i < cookies.length; i++) {
                    const cookie = cookies[i].trim();
                    // Проверяем, начинается ли cookie с нужного имени
                    if (cookie.substring(0, name.length + 1) === (name + '=')) {
                        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                        break;
                    }
                }
            }
            return cookieValue;
        }

        const csrftoken = getCookie('csrftoken');

        key_mpny=document.getElementById('key_mpny').value;


        $.ajax({            
            type: 'POST',
            url: 'get_data/',  // URL представления get_data
            data: { variable: name,
                    key_mpny: key_mpny,
                                
            },  // Передача переменной
            headers: { 'X-CSRFToken': csrftoken },  // Добавляем CSRF-токен в заголовки
            success: function (data) {
                // Обрабатываем полученные данные
                Q = data.Q;  // Данные для Q
                H = data.H;
                Qgl = data.Qgl;
                Hgl = data.Hgl
                Comment = data.Comment;
                src = data.img;
                var d = document.getElementById("IMG1");
                document.getElementById('TY1').style.display = 'block';
                document.querySelector('.container.TY-Text1').style.visibility = 'visible';
                document.getElementById('b2').style.visibility = 'visible';
                document.querySelector('.tab_prod').style.visibility = 'visible';


                /*            document.getElementById("Text1").innerHTML = Comment;*/

                Q_f = data.Q_f
                H_f = data.H_f
                Power_f = data.Power_f
                Kol = data.Kol
                DN_in = data.DN_in
                DN_out = data.DN_out
                NPSH_F = data.NPSH_F
                mass = data.mass

                Q_jok = data.Q_jok
                H_jok = data.H_jok
                A = data.A
                B = data.B
                C = data.C
                D = data.D
                F = data.F
                document.getElementById("A").innerHTML = A;
                document.getElementById("B").innerHTML = B;
                document.getElementById("C").innerHTML = C;
                document.getElementById("D").innerHTML = D;
                document.getElementById("F").innerHTML = F;

                document.getElementById("Q_f").innerHTML = Q_f;
                document.getElementById("H_f").innerHTML = H_f;
                document.getElementById("Power_f").innerHTML = Power_f;
                document.getElementById("U_f").innerHTML = 400;
                document.getElementById("Kol").innerHTML = Kol;
                document.getElementById("DN_in_f").innerHTML = 'DN ' + DN_in;
                document.getElementById("DN_out_f").innerHTML = 'DN ' + DN_out;
                document.getElementById("NPSH_F").innerHTML = NPSH_F;
                document.getElementById("mass").innerHTML = mass;
                document.getElementById("H_jokf").innerHTML = H_jok;
                /*            document.getElementById("H_jok").innerHTML = H_jok;*/
                /*    document.getElementById("Q_jok").innerHTML = Q_jok;*/
                d.src = src;

                const X = Q;
                const Y = H;
                const Names = "";

                const Xt = Qgl;
                const Yt = Hgl;
                const Namest = "";

                const data1 = []; // Массив для данных первой кривой (x и y)
                const data2 = []; // Массив для данных второй кривой (x и y)
                for (let i = 0; i < X.length; i++) {
                    data1.push({ x: X[i], y: Y[i], });
                }
                for (let i = 0; i < Xt.length; i++) {
                    data2.push({ x: Xt[i], y: Yt[i], });
                }
                // Фильтруем данные для первой кривой

                if (!ctx) {
                    const canvas = document.getElementById("myChart");
                    ctx = canvas.getContext('2d');
                }
                

                if (myChart) {
                    // Обновляем данные графика
                    myChart.data.datasets[0].data = data1;
                    if (myChart.data.datasets.length > 1) { // Проверяем, существует ли datasets[1]
                        myChart.data.datasets[1].data = data2;
                    } else {
                        //Если не существует, добавляем новый dataset
                        myChart.data.datasets.push({
                            label: 'Данные 2',
                            data: data2,
                            borderColor: 'rgb(236, 0, 0)', // Изменен цвет
                            borderWidth: 2
                        });
                    }
                    myChart.update();
                } else {
                    // Создаем график
                    const initialData = {
                        datasets: [{
                            label: 'Кривая МПНУ',
                            data: data1,
                            borderColor: 'rgb(15, 19, 121)',
                            borderWidth: 4,
                            pointRadius: 0,
                            tension: 0.5
                        }, {
                            label: 'точка',
                            data: data2,
                            borderColor: 'red', // Изменен цвет
                            borderWidth: 2,
                            borderDash: [5, 5],
                            pointRadius: 0
                        }]
                    };

                    myChart = new Chart(ctx, {
                        type: 'line',
                        data: initialData,
                         options: {
                             responsive: true,
                             /*maintainAspectRatio: false,*/
                             scales: {
                                 x: {
                                     type: 'linear', // Или 'time', если X значения - даты
                                     position: 'bottom',
                        
                                     title: {
                                         display: true,
                                         text: 'Расход, м³/ч', // Подпись оси X
                                         font: { size: 16, weight: 'bold' }
                                     }
                        
                        
                                 },
                                 y: {
                                     type: 'linear',
                                     position: 'left',
                                     beginAtZero: false,
                                     title: {
                                         display: true,
                                         text: 'Напор, м', // Подпись оси X
                                         font: { size: 16, weight: 'bold' }
                                     }
                                 }
                             },
                             plugins: {
                                 legend: {
                                     labels: {
                                         font: {           // Вложенный объект font
                                             family: 'Arial',
                                             size: 16,
                                             weight: 'normal',
                                             style: 'normal'
                                         },
                                         /*color: '#000000'  // Цвет текста легенды*/
                                     }
                                 }
                             }
                         }
                    });
                }

            },
            //error: function (xhr, status, error) {
            //    // Обработка ошибок
            //    console.error('Ошибка при запросе:', error);
            //}
        });


    }