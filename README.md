# Rivonimport discord
from discord.ext import commands

intents = discord.Intents.default()
intents.message_content = True
intents.members = True

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')

# أمر البرودكاست: !bc رسالتك هنا
@bot.command()
@commands.has_permissions(administrator=True)
async def bc(ctx, *, message):
    for member in ctx.guild.members:
        if not member.bot:
            try:
                await member.send(message)
            except:
                continue
    await ctx.send("✅ تم إرسال البرودكاست لجميع الأعضاء.")

bot.run('ضع_التوكن_هنا')\
import discord
from discord import app_commands
from discord.ext import commands

intents = discord.Intents.default()
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

# تسجيل الأوامر عند تشغيل البوت
@bot.event
async def on_ready():
    await bot.tree.sync()  # مهم لمزامنة الأوامر
    print(f"{bot.user} شغال!")

# رسالة ترحيب للأعضاء الجدد
@bot.event
async def on_member_join(member):
    channel = discord.utils.get(member.guild.text_channels, name="general")
    if channel:
        await channel.send(f"أهلاً وسهلاً بك {member.mention} في السيرفر!")

# أمر مرح
@bot.tree.command(name="hello", description="يقول مرحباً بك")
async def hello(interaction: discord.Interaction):
    await interaction.response.send_message(f"هلا {interaction.user.mention}! كيف حالك؟ 😄")

# أمر طرد عضو
@bot.tree.command(name="kick", description="يطرد عضو من السيرفر")
@app_commands.describe(member="اختر العضو اللي تبي تطرده", reason="سبب الطرد")
async def kick(interaction: discord.Interaction, member: discord.Member, reason: str = None):
    if interaction.user.guild_permissions.kick_members:
        await member.kick(reason=reason)
        await interaction.response.send_message(f"{member.mention} تم طرده بنجاح!")
    else:
        await interaction.response.send_message("ما عندك صلاحية تطرد أعضاء!", ephemeral=True)

# أمر حظر عضو
@bot.tree.command(name="ban", description="يحظر عضو من السيرفر")
@app_commands.describe(member="اختر العضو اللي تبي تحظره", reason="سبب الحظر")
async def ban(interaction: discord.Interaction, member: discord.Member, reason: str = None):
    if interaction.user.guild_permissions.ban_members:
        await member.ban(reason=reason)
        await interaction.response.send_message(f"{member.mention} تم حظره بنجاح!")
    else:
        await interaction.response.send_message("ما عندك صلاحية تحظر أعضاء!", ephemeral=True)

# أمر فك الحظر
@bot.tree.command(name="unban", description="يفك حظر عضو")
@app_commands.describe(member="اكتب العضو مع الرقم مثل Lays#1234")
async def unban(interaction: discord.Interaction, member: str):
    if interaction.user.guild_permissions.ban_members:
        banned_users = await interaction.guild.bans()
        member_name, member_discriminator = member.split('#')
        for ban_entry in banned_users:
            user = ban_entry.user
            if (user.name, user.discriminator) == (member_name, member_discriminator):
                await interaction.guild.unban(user)
                await interaction.response.send_message(f"{user.mention} تم فك الحظر عنه!")
                return
        await interaction.response.send_message("ما لقيت العضو.", ephemeral=True)
    else:
        await interaction.response.send_message("ما عندك صلاحية!", ephemeral=True)

# شغل البوت بوضع التوكن
bot.run("YOUR_BOT_TOKEN")
