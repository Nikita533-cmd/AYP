
function change_v() {
        let s = document.getElementById("vetk")
        if (s.value == "1") { document.getElementById("s2_t").innerHTML = "Расстояние от извещателя до первого отверстия"; }
        else { document.getElementById("s2_t").innerHTML = "Расстояние от извещателя до разветвления"; }
    
}
function change_vers() {
     
    
}
   

let csrfToken = '';

    // Функция для получения CSRF токена из cookies
function getCSRFToken() {
    // alert ("fgfgfg")
    if (csrfToken) return csrfToken;
     
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, 'csrftoken'.length + 1) === ('csrftoken' + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring('csrftoken'.length + 1));
                    break;
                }
            }
        }
        csrfToken = cookieValue;
        return cookieValue;
    }


    function validateRequiredInputs() {
    const requiredInputs = document.querySelectorAll('input[required]');
    const invalidInputs = [];
    
    requiredInputs.forEach(input => {
        if (!input.value.trim()) {
            invalidInputs.push(input);
            input.style.borderColor = 'red';
        }
        else 
        input.style.borderColor = '';
    });
    
    return invalidInputs;
}

 
    class ButtonHandler 
    {
        constructor() 
        {
        this.buttons = document.querySelectorAll('.button');
        
        this.init();
        }

        init()
        {
       
          
            this.buttons.forEach(button => {
                button.addEventListener('click', (e) => {
                    this.handleButtonClick(e.target);
                    
                });
         
            });
            
        }

        showMessage(text, type) 
        {
            const messageDiv = document.getElementById('smessage');
            messageDiv.textContent = text;
            messageDiv.className = 'message ' + type;
        }

        
        
                
        async handleButtonClick(button) 
        {   const buttonName = button.getAttribute('name');
            
            const submitBtn = document.getElementById('submit-btn');
            const pdfBtn = document.getElementById('getpdf');
            const vers = document.getElementById('vers');
            const h_ust = document.getElementById('H');
            const vetk_ust = document.getElementById('vetk');
            const s_otv_ust = document.getElementById('s_otv');
            const s_ust = document.getElementById('s2');
            const otv_ust = document.getElementById('otv');
            const s_vetk = document.getElementById('s1');
            
            const r_content = document.getElementById('body-content');

            var new_min=Math.round(parseFloat(s_ust.value)+parseFloat(s_otv_ust.value)*(parseFloat(otv_ust.value)-1));
            s_vetk.setAttribute("min",new_min);
            if (parseFloat(s_vetk.value)<new_min)
            {
                s_vetk.value=new_min;
            }

            const invalidInputs = validateRequiredInputs();
                              
        
            if (invalidInputs.length > 0) {
               
                alert('Заполните все обязательные поля!');
            } 
            else {
                 
                // Блокируем кнопки
                if (buttonName === 'submit') {
                    submitBtn.disabled = true;
                }    
                if (buttonName === 'getpdf') {
                    pdfBtn.disabled = true;
                    this.showMessage('Генерируется PDF');
                }              

                // Подготавливаем данные
                const data = {
                    button_name: buttonName,
                    param1: vers.value,
                    param2: h_ust.value,
                    param3: vetk_ust.value,
                    param4: s_otv_ust.value,
                    param5: s_ust.value,
                    param6: otv_ust.value,
                    param7: s_vetk.value

                };
               
                
               
                try{
                    // Отправляем запрос
                    // getCSRFToken()
                    // alert (csrfToken)
                    // alert (csrf_token) 
                    const response = await fetch('ajax-handler/', {
                        method: 'POST',
                        headers: {
                            'X-CSRFToken': getCSRFToken(),
                            // 'X-CSRFToken': '{{ csrf_token }}',
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(data)
                    })

                    if (buttonName === 'getpdf' && response.ok) 
                    {
                        // Обработка PDF ответа
                       
                        const blob = await response.blob();
                        pdfBtn.disabled = false;
                        this.downloadPDF(blob);
                        this.showMessage('PDF успешно сгенерирован и скачан!', 'success');
                        pdfBtn.style.visibility = "hidden";
                        
                       

                    }
                    else if (buttonName === 'submit' && response.ok)                    
                    {
                       
                        //Обработка JSON ответа
                        const data = await response.json();   
                        
                        
                     
                        submitBtn.disabled = false;
                        pdfBtn.style.visibility = "visible";
                        r_content.style.visibility = "visible";
                        this.showMessage('');
                        if (data.status === 'success') {
                            r_content.innerHTML = data.message;                            
                        } 
                        else 
                        {
                             // Восстанавливаем кнопки при ошибке
                            if (buttonName === 'submit') {
                              
                                submitBtn.disabled = false;
                            }
                            if (buttonName === 'getpdf') {
                              
                                pdfBtn.disabled = false;
                            }
                            this.showMessage('Ошибка: ' + data.message, 'error');

                        }
                          //  return response.json();    

                    }
                    else
                    { // Восстанавливаем кнопки при ошибке
                        if (buttonName === 'submit') {
                           
                            submitBtn.disabled = false;


                        }
                       
                            this.showMessage('Ошибка: ' + response.message, 'error');
                        
                    }


                        
                }
                catch(error) 
                {
                        // Восстанавливаем кнопки при ошибке
                        if (buttonName === 'submit') {
                           
                            submitBtn.disabled = false;
 
                        }
                                    
                        this.showMessage('Ошибка сети: ' + error.message, 'error');
                }
            
            }
        }
        
       
        
        downloadPDF(blob)
        {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = `document_${new Date().toISOString().slice(0, 10)}.pdf`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            a.remove();
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        new ButtonHandler();
        
    });
            
    