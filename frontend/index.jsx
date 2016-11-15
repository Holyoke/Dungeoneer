import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

//testing
import * as actions from './actions/session_actions';

document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('root');
    window.store = configureStore();
    window.actions = actions;
    ReactDOM.render(<h1>Welcome to Dungeoneer Baby </h1>, root);
});
