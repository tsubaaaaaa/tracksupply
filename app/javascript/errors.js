// app/javascript/errors.js

// この関数は、モーダルが存在すればそれを閉じるだけ。
// イベントリスナーは document に設定するので、この関数自体を turbo:load で毎回呼ぶ必要性は減る。
function closeModalIfPresent() {
  const errorModalOverlay = document.getElementById('error-modal-overlay');
  if (errorModalOverlay && errorModalOverlay.style.display !== 'none') {
    console.log('Closing modal via closeModalIfPresent...');
    errorModalOverlay.style.display = 'none';
  }
}

// イベントリスナーは一度だけ、document レベルで設定する
// turbo:load だと重複する可能性があるので、DOMContentLoaded か、
// もっとシンプルにスクリプト読み込み時に一度だけ設定する。
// ただし、Turbo Drive 環境では、ページ遷移でリスナーがどうなるか注意が必要。
// ここでは、turbo:load の中で毎回リスナーを設定し直すアプローチの代わりに、
// document への委任を試みます。

let listenersAttached = false; // リスナーが設定されたかのフラグ

function setupGlobalModalListeners() {
  if (listenersAttached) {
    // console.log('Global modal listeners already attached.');
    return;
  }

  console.log('Setting up global modal event listeners on document.');

  document.addEventListener('click', (event) => {
    const errorModalOverlay = document.getElementById('error-modal-overlay');
    if (!errorModalOverlay || errorModalOverlay.style.display === 'none') {
      return; // モーダルがないか非表示なら何もしない
    }

    // ×ボタンがクリックされたか、またはオーバーレイ自体がクリックされたか
    if (event.target.classList.contains('close-modal-button') || event.target === errorModalOverlay) {
      console.log('Close condition met by click (global listener).');
      closeModalIfPresent();
    }
  });

  document.addEventListener('keydown', (event) => {
    const errorModalOverlay = document.getElementById('error-modal-overlay');
    if (!errorModalOverlay || errorModalOverlay.style.display === 'none') {
      return; // モーダルがないか非表示なら何もしない
    }

    if (event.key === 'Escape') {
      console.log('ESC key pressed (global listener).');
      closeModalIfPresent();
    }
  });

  listenersAttached = true;
}

// turbo:load のたびに、リスナーが未設定なら設定する
document.addEventListener('turbo:load', () => {
  console.log('turbo:load event fired. Ensuring global modal listeners are set up.');
  // このタイミングでモーダルが存在するかどうかは関係なく、グローバルなリスナーを設定する
  setupGlobalModalListeners();

  // もしエラーモーダルが最初から表示されている場合（バリデーションエラーでページが再表示された直後）
  // CSSで表示されているはずなので、JSで表示する処理は不要
  const errorModalOverlay = document.getElementById('error-modal-overlay');
  if (errorModalOverlay) {
    console.log('Error modal is present in DOM on turbo:load.');
    // 必要ならここで errorModalOverlay.style.display = 'flex'; などで表示を確実にするが、
    // ERBの if @individual.errors.any? で出力されていればCSSで表示されるはず。
  }
});