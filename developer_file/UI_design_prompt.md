Help me design a modern recipe generation + supermarket delivery app. 
The idea of this app is to expand modern supermarket delivery app. Except common browser products, shopping cart, delivery, puchase and usual user setting functions, this app have a recipe generate function. By user enter perference texts, the app call LLM API to generate recommend meal plan with recipes and ingredients. The meal plan store in the app or app server, and ingredients go to cart so that user can easily manage and buy daily meals.

First this app has 3 main page [Meal planning, Shopping, and Setting], with permanent bottom navigation bar for 3 of them.

Main page "Meal planning" is for user to view existing meal plan or making new meal plan. upper half screen is calendar and lower half is the existing plan list. right bottom coner has a round "+" button for create a new plan. At this page I want to strictly limit the calendar part to only half of the screen, so the calendar part should be a continuous page that can be slide up and down. The month and year written on the calendar background for space saving. At lower half, the existing plan list is a list of meal (breakfast, lunch or dinner). One or more recipe cards below each meal. The meal should shows the date and time, and the recipe card cover should shows the main information such as the dish picture, dish name, serve person and cooking time.

By user click each recipe card, it brings to the "Recipe card detail" subpage. A common Mobile recipe page, with dish name on the top, follow by picture, serves, tools required, cooking time, list of ingredients, and Cooking steps.

”+“ button in the "Meal planning" main page brings user to "Preference collection" subpage, upper half has a scroll bar for setting budges, small add&minus buttons for set meals per day (budget and meals per day setting at same line), and a similar but interactble calender with "meal planning page", which user and swipe on the day to select meal plan range. lower half where it collects user's preferences, it just a enter box (with voice transcript button) like memo and user can enter text about what dish/ingredient he must have, and what dish/ingredients must not appear. Done button at bottom but above navigation bar.

The Done button brings user to "New meals" subpage. This page should keep same style with "Meal planning" main page lower half like the existing plan list. This page listed new generated meals (breakfast, lunch or dinner). One or more recipe cards below each meal. The meal should shows the date and time, and the recipe card cover should shows the main information such as the dish picture, dish name, serve person and cooking time. However, very different part is each recipe card cover listed in this page will add a "refresh" mark button, user can mark this unwanted dish. At bottom but above navigation bar, there are "regenerate" button for regenerate unwanted dish, and "Done" button for move to "View cart" subpage.

Main page "Shopping" is a common style supermarket page, with search bar at top and listed many product categories in the page. A cart icon button at right bottom coner lead to "View cart" subpage. click product will lead to "Product detail" subpage.

"Product detail" subpage contains product picture, product name, product price, product description, selected number, add to cart button. Also, same cart icon button at right bottom coner.

"view cart" subpage is a regular shopping cart page, each item in cart has remove buttom, number adjust buttom, and price. below shows total items price, delivery address (click address will expand address book for user to select or enter new location), and checkout button. A basket icon button at right bottom coner back to earlier "shopping" or "product detail" page. Checkout button brings to "Receipt" sub page. Navigation bar still at most bottom.


The "Setting" page is like most app, for user to manage account, address book, tie payment method, view orders, etc.

Therefor, the list of pages are:
1. Meal planning
2. Recipe card detail
3. Preference collection
4. New meals
5. Shopping
6. Product detail
7. View cart
8. Receipt
9. Setting
However, I want you ONLY generate the first 4 page [Meal planning , Recipe card detail, Preference collection, New meals] at this moment to see the style.
