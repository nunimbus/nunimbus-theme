<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm','hardened-encryption'); section>
    <#if section = "header">
        ${msg('registerTitle')}
        <style>
        </style>
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
            <div class="${properties.kcFormGroupTopClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}"></label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName"
                           value="${(register.formData.firstName!'')}"
                           aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                           placeholder="${msg('firstName')}"
                    />

                    <#if messagesPerField.existsError('firstName')>
                        <span id="input-error-firstname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupMiddleClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}"></label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName"
                           value="${(register.formData.lastName!'')}"
                           aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                           placeholder="${msg('lastName')}"
                    />

                    <#if messagesPerField.existsError('lastName')>
                        <span id="input-error-lastname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupMiddleClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}"></label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" class="${properties.kcInputClass!}" name="email"
                           value="${(register.formData.email!'')}" autocomplete="email"
                           aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                           placeholder="${msg('mail')}"
                    />

                    <#if messagesPerField.existsError('email')>
                        <span id="input-error-email" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('email'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupMiddleClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}"></label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="username" class="${properties.kcInputClass!}" name="username"
                               value="${(register.formData.username!'')}" autocomplete="disable"
                               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                               placeholder="${msg('username')}"
                        />

                        <#if messagesPerField.existsError('username')>
                            <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="${properties.kcFormGroupMiddleClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password" class="${properties.kcLabelClass!}"></label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="password" id="password" class="${properties.kcInputClass!}" name="password"
                               autocomplete="new-password"
                               aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                               placeholder="${msg('password')}"
                        />

                        <#if messagesPerField.existsError('password')>
                            <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormGroupBottomClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password-confirm"
                               class="${properties.kcLabelClass!}"></label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="password" id="password-confirm" class="${properties.kcInputClass!}"
                               name="password-confirm"
                               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                               placeholder="${msg('passwordConfirm')}"
                        />

                        <#if messagesPerField.existsError('password-confirm')>
                            <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options">
					<input id="hardened-encryption" name="hardened-encryption" class="collapsible" type="checkbox"/>
					<label for="hardened-encryption" class="lbl-toggle">
						<span class="checkmark-text">Enable Hardened Encryption</span>
					</label>

					<#if messagesPerField.existsError('hardened-encryption')>
						<span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
							${kcSanitize(messagesPerField.get('hardened-encryption'))?no_esc}
						</span>
					</#if>

					<div class="content">
                        <div class="collapsible-content">
							<br>
							<p>Any program with the ability to recover lost passwords implicitly allows administrators to access user accounts. While NuNimbus has a policy against accessing user data, some users may want a greater level of security.</p><br>
							<p>All accounts are encrypted with user-specific keys, but by enabling this option, your encryption keys will be directly linked to your password. You can change your password, but:</p><br>
							<p style="font-weight: bold; text-align: center; text-transform: uppercase;">If you forget your password, it cannot be recovered. Your data <u>WILL</u> be lost. We will <u>NOT</u> be able to help you.</p><br>
							<p>To proceed, please type the following message in the box below (case and punctuation included):</p><br>
							<p id="encryption-text" style="font-weight: bold; text-align: center;">I understand the risks of forgetting my password.</p><br>
							<div class="${properties.kcInputWrapperClass!}">
								<input type="text" id="encryption-message" class="${properties.kcInputClass!}" name="encryption-message" 
									value="${(register.formData.username!'')}" autocomplete="disabled"
									aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
									onchange
									onpropertychange
									onkeyuponpaste
									oninput="changeFunction()"
								/>

								<#if messagesPerField.existsError('username')>
									<span id="input-error-encryption-message" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
										${kcSanitize(messagesPerField.get('username'))?no_esc}
									</span>
								</#if>
							</div>
						</div>
					</div>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg('backToLogin'))?no_esc}</a></span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg('doRegister')}"/>
                </div>
            </div>
        </form>
        <script>
		function changeFunction() {
			if (document.getElementById("encryption-message").value == document.getElementById("encryption-text").innerText) {
				document.querySelector('input[type=submit]').disabled = false;
				document.querySelector('input[type=submit]').style.backgroundColor ="#0082c9"
			}
			else {
				document.querySelector('input[type=submit]').disabled = true;
				document.querySelector('input[type=submit]').style.backgroundColor ="grey"
			}
		}
        
		var coll = document.getElementsByClassName("collapsible");
		var i;

		for (i = 0; i < coll.length; i++) {
			coll[i].addEventListener("click", function() {
				this.classList.toggle("active");
				var content = this.parentElement.querySelector('.content');;
				if (content.style.maxHeight) {
					content.style.maxHeight = null;
				}
				else {
					content.style.maxHeight = content.scrollHeight + "px";
				} 

				// If the checkbox is checked, display the output text
				if (this.checked == true){
					document.querySelector('input[type=submit]').disabled = true;
					document.querySelector('input[type=submit]').style.backgroundColor ="grey"
				} else {
					document.querySelector('input[type=submit]').disabled = false;
					document.querySelector('input[type=submit]').style.backgroundColor ="#0082c9"
				}

				document.getElementById("encryption-message").value = "";
			});
		}

		// Password validator
		var validatorDiv = document.createElement('div');		
		validatorDiv.id = 'password-validator';

		validatorDiv.innerHTML = ' \
			<div class="arrow"></div> \
			<div class="inputValidationIndicator"> \
				<h2 class="passwordHeader">Your password must include:</h2> \
				<ul class="conditionList"> \
					<li class="conditionWrapper length"><span class="condition"> or more characters</span></li> \
					<li class="conditionWrapper uppercase"><span class="condition">an uppercase letter</span></li> \
					<li class="conditionWrapper lowercase"><span class="condition">a lowercase letter</span></li> \
					<li class="conditionWrapper number"><span class="condition">a number</span></li> \
					<li class="conditionWrapper special"><span class="condition">a special character (! # $ ? % @)</span></li> \
				</ul> \
			</div>';

		document.querySelector('input[type=password]').insertAdjacentElement('afterend', validatorDiv);

		const conditions = {
			"length":    12,
			"uppercase": true,
			"lowercase": true,
			"number":    false,
			"special":   false,
		};

		var validations = {
		};

		const pwInput = document.querySelector('input[type=password]');
		const validator = document.querySelector('#password-validator');
		const submit = document.querySelector('input[type=submit]');
		var valid = false;

		window.onload = function(){
			submit.disabled = true;

			Object.keys(conditions).forEach(key => {
				var element = validator.querySelector('.conditionWrapper.' + key);

				if (conditions[key] == false) {
					element.style.display = 'none';
				}
				else {
					validations[key] = false;
				}
				
				if (key == 'length') {
					element.textContent = conditions.length + element.textContent;
				}
			});
		};

		pwInput.addEventListener('focusin', function() {
			pwInput.classList.toggle('error', false);

			if (valid == false) {
				const cssObj = window.getComputedStyle(pwInput, null);
				validator.style.width = cssObj.width;
				validator.style.display = "block";
			}
		});

		pwInput.addEventListener('focusout', function() {
			validatePassword();
			validator.style.display = "none";
		});

		pwInput.addEventListener('keyup', validatePassword);

		function validatePassword() {
			var validationsMet = true;
			Object.keys(validations).forEach(key => {
				var element = validator.querySelector('.conditionWrapper.' + key);

				switch(key) {
					case 'length':
						if (pwInput.value.length >= conditions.length) {
							validations[key] = true;
						}
						else {
							validations[key] = false;
						}
						break;
					case 'uppercase':
						if (pwInput.value.search(/.*[A-Z].*/) == 0) {
							validations[key] = true;
						}
						else {
							validations[key] = false;
						}
						break;
					case 'lowercase':
						if (pwInput.value.search(/.*[a-z].*/) == 0) {
							validations[key] = true;
						}
						else {
							validations[key] = false;
						}
						break;
					case 'number':
						if (pwInput.value.search(/.*[0-9].*/) == 0) {
							validations[key] = true;
						}
						else {
							validations[key] = false;
						}
						break;
					case 'special':
						if (pwInput.value.search(/.*[^a-zA-Z0-9].*/) == 0) {
							validations[key] = true;
						}
						else {
							validations[key] = false;
						}
						break;
				}
				
				if (validations[key] == false) {
					element.style.color = 'red';
					validationsMet = false;
				}
				else {
					element.style.color = 'green';				
				}
			});
			
			valid = validationsMet;
			
			if (valid) {
				submit.disabled = false;
				pwInput.classList.toggle('error', false);
				validator.classList.toggle('fade-out', true);
			}
			else {
				pwInput.classList.toggle('error', true);
				submit.disabled = true;
				validator.classList.toggle('fade-out', false);
				validator.style.display = "block";		
			}
		}
        </script>
    </#if>
</@layout.registrationLayout>
