
document.addEventListener('turbo:load', () => {
  const addInventoryButton = document.getElementById('add-inventory-button');
  const inventoriesContainer = document.getElementById('inventories-container');
  const inventoryFieldsTemplate = document.getElementById('inventory-fields-template');

  if (addInventoryButton && inventoriesContainer && inventoryFieldsTemplate) {
    addInventoryButton.addEventListener('click', () => {
        console.log('「部位・重量を追加」ボタンがクリックされました！'); // ★追加

      const uniqueIndex = new Date().getTime(); // 新しいレコード用の一意なID
      const newFieldsContent = inventoryFieldsTemplate.innerHTML.replace(/__INDEX__/g, uniqueIndex);
      const newFieldsDiv = document.createElement('div');
      // newFieldsDiv.classList.add('form-stock-section', 'nested-fields'); // テンプレート側でクラス指定してるので、innerHTMLをそのまま使うなら不要
      newFieldsDiv.innerHTML = newFieldsContent;

      // テンプレートから複製する場合、最初のdivが .nested-fields になるようにする
      // inventoriesContainer.appendChild(newFieldsDiv.firstElementChild); // この方がより正確
      // もしくはテンプレートのinnerHTMLを直接コンテナに追加し、その後でボタンのイベントリスナーを設定する
      // 今回は newFieldsDiv をそのまま追加する形にする (テンプレートのラッパーdivは複製されないので、innerHTMLで取得した中身を新しいdivに入れる)

      // templateタグを使う場合 (推奨)
      const templateContent = inventoryFieldsTemplate.content.cloneNode(true);
      templateContent.querySelectorAll('[name*="__INDEX__"]').forEach(input => {
         input.name = input.name.replace(/__INDEX__/g, uniqueIndex);
      });
      templateContent.querySelectorAll('[id*="__INDEX__"]').forEach(element => { // idもユニークにする場合
         element.id = element.id.replace(/__INDEX__/g, uniqueIndex);
         if (element.tagName === 'LABEL') {
           element.htmlFor = element.htmlFor.replace(/__INDEX__/g, uniqueIndex);
         }
      });
      inventoriesContainer.appendChild(templateContent);
    });
  }

  // 削除ボタンの処理 (イベント委任)
  if (inventoriesContainer) {
    inventoriesContainer.addEventListener('click', (event) => {
      if (event.target.classList.contains('remove-part-button')) {
        const fieldGroup = event.target.closest('.nested-fields');
        if (fieldGroup) {
          // 既存レコードの削除の場合、_destroyフィールドの値を "1" にする
          const destroyField = fieldGroup.querySelector('input[type="hidden"][name*="_destroy"]');
          if (destroyField) {
            destroyField.value = '1';
            fieldGroup.style.display = 'none'; // 画面上から隠す
          } else {
            // 新規追加された（まだIDがない）フィールドの場合はDOMから完全に削除
            fieldGroup.remove();
          }
        }
      }
    });
    }
});