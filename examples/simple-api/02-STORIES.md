# User Stories - API REST Todo List

## Epic: CRUD Todo API

### Story 1: Créer une tâche
**Taille:** S | **Priorité:** P0

**En tant que** développeur,
**Je veux** créer une nouvelle tâche via POST,
**Afin de** ajouter des items à ma liste.

**Critères d'acceptance:**
```gherkin
Given une requête POST /todos avec {"title": "Ma tâche"}
When je soumets la requête
Then je reçois un 201 Created
And la réponse contient l'id généré
And completed est false par défaut
```

**Tâches techniques:**
- [ ] Route POST /todos
- [ ] Validation du body (title requis)
- [ ] Insertion SQLite
- [ ] Retour JSON avec id

---

### Story 2: Lister les tâches
**Taille:** XS | **Priorité:** P0

**En tant que** développeur,
**Je veux** récupérer toutes les tâches via GET,
**Afin de** voir l'état de ma liste.

**Critères d'acceptance:**
```gherkin
Given des tâches existent en base
When je fais GET /todos
Then je reçois un 200 OK
And la réponse est un tableau de todos
```

---

### Story 3: Récupérer une tâche
**Taille:** XS | **Priorité:** P1

**En tant que** développeur,
**Je veux** récupérer une tâche par son id,
**Afin de** voir ses détails.

**Critères d'acceptance:**
```gherkin
Given une tâche avec id=1 existe
When je fais GET /todos/1
Then je reçois un 200 OK avec la tâche

Given aucune tâche avec id=999
When je fais GET /todos/999
Then je reçois un 404 Not Found
```

---

### Story 4: Mettre à jour une tâche
**Taille:** S | **Priorité:** P1

**En tant que** développeur,
**Je veux** modifier une tâche existante,
**Afin de** changer son titre ou statut.

**Critères d'acceptance:**
```gherkin
Given une tâche avec id=1 existe
When je fais PUT /todos/1 avec {"completed": true}
Then je reçois un 200 OK
And la tâche est mise à jour
And updatedAt est modifié
```

---

### Story 5: Supprimer une tâche
**Taille:** XS | **Priorité:** P2

**En tant que** développeur,
**Je veux** supprimer une tâche,
**Afin de** nettoyer ma liste.

**Critères d'acceptance:**
```gherkin
Given une tâche avec id=1 existe
When je fais DELETE /todos/1
Then je reçois un 204 No Content
And la tâche n'existe plus
```

---

## Readiness Check: 14/15 ✅

| Critère | Score |
|---------|-------|
| Stories INVEST | 3/3 |
| Critères Given/When/Then | 3/3 |
| Estimations cohérentes | 2/2 |
| Priorités définies | 2/2 |
| Dépendances identifiées | 2/2 |
| Risques techniques | 2/3 |

**Prêt pour implémentation.**
