<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

<#if section = "header">
${msg("loginTotpTitle")}
<#elseif section = "form">
<ol id="kc-totp-settings">
	        <li class="totp-step">
                ${msg("loginTotpStep1")}

                <ul id="kc-totp-supported-apps">
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>

            <div id="totp-manual" class="hidden">
                <li class="totp-step">
                    ${msg("loginTotpManualStep2")}
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    ${msg("loginTotpManualStep3")}
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            </div>

            <div id="totp-qr" class="hidden">
                <li class="totp-step">
                    ${msg("loginTotpStep2")}
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </div>

            <div id="totp-link" class="hidden">
                <li class="totp-step">
                    Click the button below.
                    <p>
                        <a href="otpauth://totp/${(realm.displayName)?replace(" ", "%20")}:${(totp.username)}?secret=${(totp.totpSecretEncoded)?replace(" ", "")}&period=${(totp.policy["period"])}&algorithm=${(totp.policy["algorithm"])?replace("Hmac", "")}&digits=${(totp.policy["digits"])}">
                            <input id="totp-link-button" value="Add to OTP App" class="button primary pf-m-block btn-lg" type="submit">
                        </a>
                    </p>
                    <p><a id="mode-manual-alt">Add OTP Details Manually</a></p>
                </li>
            </div>

            <li class="totp-step">
                ${msg("loginTotpStep3")}
            </li>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="totp" name="totp" autocomplete="off" class="${properties.kcInputClass!}" placeholder=${msg("authenticatorCode")}
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                    />

                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </#if>

                </div>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>

            <li class="totp-step">
                ${msg("loginTotpStep3DeviceName")}
            </li>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" class="${properties.kcInputClass!}" id="userLabel" name="userLabel" placeholder=${msg("loginTotpDeviceName")} autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                    />

                    <#if messagesPerField.existsError('userLabel')>
                        <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <#if isAppInitiatedAction??>
                <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
                <button type="submit"
                        class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}"
                        id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                </button>
            <#else>
                <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
            </#if>
        </form>
    </ol>
    </#if>
</@layout.registrationLayout>
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
<script>
    if (Modernizr.touch) {
        document.getElementById('totp-link').classList.remove('hidden');
    }
    else {
        document.getElementById('totp-qr').classList.remove('hidden')
    }

    document.getElementById('mode-manual').addEventListener("click", function() {
        document.getElementById('totp-qr').classList.add('hidden')
        document.getElementById('totp-manual').classList.remove('hidden')
    });

    document.getElementById('mode-barcode').addEventListener("click", function() {
        document.getElementById('totp-qr').classList.remove('hidden')
        document.getElementById('totp-manual').classList.add('hidden')
    });

    document.getElementById('mode-manual-alt').addEventListener("click", function() {
        document.getElementById('totp-link').classList.add('hidden')
        document.getElementById('totp-manual').classList.remove('hidden')
    });
</script>
