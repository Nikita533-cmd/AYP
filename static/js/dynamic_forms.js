// static/js/dynamic_forms.js
let branchData = {};

function updateForms() {
    const branchesCount = document.getElementById('branchesCount').value;
    
    fetch(`/test/get-forms/?count=${branchesCount}`)
        .then(response => response.text())
        .then(html => {
            document.getElementById('branchesContainer').innerHTML = html;
            initializeBranchForms();
        });
}

function updateBranchForms(branchNum) {
    const container = document.querySelector(`[data-branch="${branchNum}"] .sprinkler-container`);
    const count = document.getElementById(`branch_${branchNum}_sprinklers`).value;
    
    let html = '';
    for(let i = 1; i <= count; i++) {
        html += `
            <div class="sprinkler p-3 mb-3 border rounded bg-light">
                <h6>💧 Ороситель ${i}</h6>
                <div class="row">
                    <div class="col-md-3">
                        <input type="number" name="branch_${branchNum}_spr_${i}_length" 
                               placeholder="Длина, м" class="form-control" step="0.1" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" name="branch_${branchNum}_spr_${i}_diameter" 
                               placeholder="Диаметр, мм" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" name="branch_${branchNum}_spr_${i}_pressure" 
                               placeholder="Давление" class="form-control" step="0.1" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" name="branch_${branchNum}_spr_${i}_flow" 
                               placeholder="Расход" class="form-control">
                    </div>
                </div>
            </div>
        `;
    }
    container.innerHTML = html;
}

function initializeBranchForms() {
    // Инициализация для каждой ветки
    document.querySelectorAll('.branch').forEach(branch => {
        const branchNum = branch.dataset.branch;
        updateBranchForms(branchNum);
    });
}

// Автозапуск
document.addEventListener('DOMContentLoaded', () => {
    updateForms();
});
