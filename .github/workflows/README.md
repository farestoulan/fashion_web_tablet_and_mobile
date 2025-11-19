# CI/CD Workflow Setup

## Required Secrets

To enable automatic deployment to Vercel, you need to add the following secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Navigate to **Settings → Secrets and variables → Actions**
3. Click **New repository secret**
4. Add the following secrets:

### VERCEL_TOKEN
- Go to: https://vercel.com/account/tokens
- Click **Create Token**
- Give it a name (e.g., "GitHub Actions")
- Copy the token and add it as `VERCEL_TOKEN` secret

### VERCEL_ORG_ID
- Go to: https://vercel.com/account
- Copy your **Team ID** or **User ID** (this is your Organization ID)
- Add it as `VERCEL_ORG_ID` secret

### VERCEL_PROJECT_ID
- Go to your Vercel project: https://vercel.com/dashboard
- Select your project: `fashion-web-tablet-mobile`
- Go to **Settings → General**
- Copy the **Project ID**
- Add it as `VERCEL_PROJECT_ID` secret

**OR** you can get these values by running locally:
```bash
# Install Vercel CLI
npm install -g vercel

# Link your project (if not already linked)
vercel link

# Check the .vercel/project.json file for the IDs
cat .vercel/project.json
```

## How it works

When you push code to the `main` branch:
1. ✅ The workflow will automatically trigger
2. ✅ It will build your Flutter web app (`flutter build web --release`)
3. ✅ Deploy it to Vercel production environment
4. ✅ Your app will be available at: https://fashion-web-tablet-mobile.vercel.app/

## Testing the Workflow

After adding the secrets, you can test by:
1. Making a small change to your code
2. Committing and pushing to the `main` branch
3. Check the Actions tab in GitHub to see the deployment progress

