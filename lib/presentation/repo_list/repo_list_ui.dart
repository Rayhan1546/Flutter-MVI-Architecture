import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/edit_button.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/repo_list/repo_list_view_model.dart';
import 'package:github_repo_list/presentation/widgets/custom_text_field.dart';
import 'package:github_repo_list/utils/builder_extension.dart';

class RepoListUi extends StatefulWidget {
  const RepoListUi({super.key});

  @override
  State<RepoListUi> createState() => _RepoListUiState();
}

class _RepoListUiState extends State<RepoListUi> {
  final viewModel = RepoListViewModel();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void clearTextFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Handler"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            _buildHeaders(context),
            const SizedBox(height: 24),
            _oldPasswordTextField(context),
            const SizedBox(height: 24),
            _newPasswordTextField(context),
            const SizedBox(height: 24),
            _confirmNewPasswordTextField(context),
            const SizedBox(height: 40),
            _buildUpdateButton(context),
            const SizedBox(height: 60),
            _buildSuccessMessage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaders(BuildContext context) {
    return Row(
      children: [
        Text(
          "Password",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
        ),
        const Spacer(),
        viewModel.passwordStates.build(
          buildWhen: (prev, now) {
            return prev.isPasswordEditMode != now.isPasswordEditMode;
          },
          builder: (context, states, _) {
            print("Edit Button");
            return Visibility(
              visible: !states.isPasswordEditMode,
              child: EditButton(
                onPressed: () => viewModel.togglePasswordEditBtnState(true),
                buttonName: "Edit",
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _oldPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.oldPasswordErrorText != now.oldPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state, _) {
        print("Old Password");
        return CustomTextField(
          controller: oldPasswordController,
          textFieldName: 'old Password',
          enable: state.isPasswordEditMode,
          errorText: state.oldPasswordErrorText?.getError(),
          onChanged: (password) => viewModel.onChangedOldPassword(
            oldPassword: password,
          ),
        );
      },
    );
  }

  Widget _newPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.newPasswordErrorText != now.newPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state, _) {
        print("New Password");
        return CustomTextField(
          controller: newPasswordController,
          textFieldName: 'New Password',
          enable: state.isPasswordEditMode,
          errorText: state.newPasswordErrorText?.getError(),
          onChanged: (newPassword) => viewModel.onChangedNewPassword(
            newPassword: newPassword,
          ),
        );
      },
    );
  }

  Widget _confirmNewPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.confirmNewPasswordErrorText !=
                now.confirmNewPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state, _) {
        print("Confirm New Password");
        return CustomTextField(
          controller: confirmNewPasswordController,
          textFieldName: 'Confirm New Password',
          enable: state.isPasswordEditMode,
          errorText: state.confirmNewPasswordErrorText?.getError(),
          onChanged: (confirmNewPassword) {
            viewModel.onChangedConfirmNewPassword(
              confirmNewPassword: confirmNewPassword,
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.showButton != now.showButton ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, states, _) {
        print("primary Button");
        return Visibility(
          visible: states.isPasswordEditMode,
          child: PrimaryButton(
            label: 'Update Password',
            onPressed: () {
              clearTextFields();
              viewModel.onTapUpdatePasswordBtn();
            },
            minWidth: double.infinity,
            isDisabled: !states.showButton,
          ),
        );
      },
    );
  }

  Widget _buildSuccessMessage(BuildContext context) {
    return viewModel.passwordStates.buildFor(
      select: (state) => state.showSuccessMessage,
      builder: (context, state, _) {
        print("Success Message");
        return Visibility(
          visible: state.showSuccessMessage,
          child: Text(
            'Successfully updated the password.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
