const {test, expect} = require('@playwright/test');

test('user can add a task', async ({page}) => {
    await page.goto('http://127.0.0.1:5500/');
    await page.fill('#task-input', 'Test task');
    await page.click('#add-task');

    const taskTest = page.textContent('.task');
    expect(taskText).toContain('Test task');
});

test('user can delete a task', async ({page}) => {
    await page.goto('http://127.0.0.1:5500/');
    await page.fill('#task-input', 'Test task');
    await page.click('#add-task');
    await page.click('.task .delete-task');

    const tasks = await page.$$eval('.task', 
        tasks => tasks.map(task => task.textContent)
    );
    expect(tasks).not.toContain('Test Task');
});

test('user can mark complete a task', async ({page}) => {
    await page.goto('http://127.0.0.1:5500/');
    await page.fill('#task-input', 'Test task');
    await page.click('#add-task');
    await page.click('.task .task-completed');

    const task = await page.$('.task.completed');
    expect(task).not.toBeNull();
});

test('user can filter tasks', async ({page}) => {
    await page.goto('http://127.0.0.1:5500/');
    await page.fill('#task-input', 'Test task');
    await page.click('#add-task');
    await page.click('.task .task-complete');
    await page.selectOption('#filter', 'Completed');

    const tasks = await page.$('.completed');
    expect(tasks).not.toBeNull();
});