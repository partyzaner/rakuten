/// <reference types="Cypress" />

/*
If you have no access from your location to https://rakuten.tv/mt,
then change url constant to proper location. It should work as well.
(You can not access different location using VPN/proxy)
*/

context('Rakuten.tv basic functionality', () => {

    const url = 'https://rakuten.tv/mt'
    const email = Math.random().toString(36).substring(7) + '@' + 'rakuten1.tv';
    const password = '12345678'
    const movie = 'Avatar'
    const director= 'James Cameron'
    const default_timeout = 10000

    beforeEach(() => {
        cy.clearCookies()
        cy.visit(url)
    })

    afterEach(() => {
        logout()
        cy.clearCookies()
    })

    it ('Register new user', ()=> {
        cy.get("a[data-test-id='menu-desktop-register-link']").click()
            .get("div.card--register input[name='email']").type(email)
            .get("div.card--register input[name='emailConfirmation']").type(email)
            .get("div.card--register input[name='password']").type(password)
            .get("div.i-checkbox label[for='terms_check_register']").click()
            .get("div.card--register div.button__contents").click()
            .get("div.card--register div.button__contents", { timeout: default_timeout })
            .should('not.be.visible')
            .get("div.nav__items__user.nav__items__user--logged").should('contain', email.split("@")[0])
    })

    it('Login to rakuten', () => {
        login()
        cy.get("div.nav__items__user.nav__items__user--logged").should('contain', email.split("@")[0])
    })

    it('Search content and check content detail page', ()=> {
        login()
        cy.get("input[name='search']").type(movie, {delay: 100})
        cy.get("ul.search__results div.result__title").should('contain', movie)
        cy.get("ul.search__results div.result__title").first().trigger("mouseover").click()
        cy.get("a.castface--vip").should("contain", director)
    })

    it('Add content to wish list', ()=> {
        login()
        cy.get("input[name='search']").type(movie, {delay: 100})
        cy.get("ul.search__results div.result__title").first().trigger("mouseover").click()
            .get("div.detail span.round-action--wishlist").click()
        cy.get("div.notifications span.notifications__item__message__type",{ timeout: default_timeout }).should("exist")
        cy.get("div.nav__items__user--logged ul.navmenu__parent__child").invoke("show")
        cy.get("a span.icon__wishlist").click()
        cy.get("div.contents--wishlist div.list__item--movies img")
            .should('have.attr', 'title', movie)

    })

    function login() {
        cy.get("a[data-test-id='menu-desktop-login-link']").click()
            .get("div.card--login input[name='email']").type(email)
            .get("div.card--login input[name='password']").type(password)
            .get("div.card--login div.button__contents").click()
            // .wait(2000)
            .get("div.slick-list",{ timeout: default_timeout }).should('exist')
    }

    function logout() {
        cy.get("div.nav__items__user--logged ul.navmenu__parent__child").invoke("show")
        .get("ul.navmenu__parent__child span.icon__logout").click()
        cy.get("a[data-test-id='menu-desktop-register-link']",{ timeout: default_timeout }).should("exist")
    }
})